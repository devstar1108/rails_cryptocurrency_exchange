class Currency < ActiveYamlBase
  include International
  include ActiveHash::Associations

  field :visible, default: true

  self.singleton_class.send :alias_method, :all_with_invisible, :all
  def self.all
    all_with_invisible.select &:visible
  end

  def self.enumerize
    all_with_invisible.inject({}) {|memo, i| memo[i.code.to_sym] = i.id; memo}
  end

  def self.codes
    @keys ||= all.map &:code
  end

  def self.ids
    @ids ||= all.map &:id
  end

  def self.assets(code)
    where(code: code).first[:assets]
  end

  def precision
    self[:precision]
  end

  def api
    raise unless coin?
    CoinRPC[code]
  end

  def fiat?
    not coin?
  end

  def balance_cache_key
    "peatio:hotwallet:#{code}:balance"
  end

  def balance
    Rails.cache.read(balance_cache_key) || 0
  end

  def decimal_digit
    self.try(:default_decimal_digit) || (fiat? ? 2 : 4)
  end

  def refresh_balance
    Rails.cache.write(balance_cache_key, api.safe_getbalance) if coin?
  end

  def blockchain_url(txid)
    raise unless coin?
    blockchain.gsub('#{txid}', txid.to_s)
  end

  def address_url(address)
    raise unless coin?
    self[:address_url].try :gsub, '#{address}', address
  end

  def quick_withdraw_max
    @quick_withdraw_max ||= BigDecimal.new self[:quick_withdraw_max].to_s
  end

  def as_json(options = {})
    {
      key: key,
      code: code,
      coin: coin,
      blockchain: blockchain
    }
  end

  def summary
    locked = Account.locked_sum(code)
    balance = Account.balance_sum(code)
    sum = locked + balance

    coinable = self.coin?
    hot = coinable ? self.balance : nil

    unprocessed_amount = Withdraw.unprocessed_amount(code)

    {
      name: self.code.upcase,
      sum: sum,
      balance: balance,
      locked: locked,
      coinable: coinable,
      hot: hot,
      unprocessed_amount: unprocessed_amount
    }
  end

  def weekly_weighted_price
    trades = Trade.this_week
    this_total_volume = 0
    this_week_weighted_price = 0
    trades.each do |trade|
      if trade.market.ask_currency.id == id
        this_week_weighted_price += trade.price * trade.volume
        this_total_volume += trade.volume
      end
    end

    if code != 'btc' && this_total_volume != 0
      this_week_weighted_price = this_week_weighted_price / this_total_volume
    else
      this_week_weighted_price = -1
    end

    trades = Trade.last_week
    last_total_volume = 0
    last_week_weighted_price = 0
    trades.each do |trade|
      if trade.market.ask_currency.id == id
        last_week_weighted_price += trade.price * trade.volume
        last_total_volume += trade.volume
      end
    end

    if code != 'btc' && last_total_volume != 0
      last_week_weighted_price = last_week_weighted_price / last_total_volume
    else
      last_week_weighted_price = -1
    end

    return if self.code == "btc"

    {
        name: self.code.upcase,
        last_week_weighted_price: last_week_weighted_price,
        this_week_weighted_price: this_week_weighted_price,
        last_week_total_volume: last_total_volume,
        this_week_total_volume: this_total_volume,
    }

  end
end
