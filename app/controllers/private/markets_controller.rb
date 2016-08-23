module Private
  class MarketsController < BaseController
    skip_before_action :auth_member!, only: [:show]
    before_action :visible_market?
    skip_after_action :set_default_market, only: [:market_withdraw]


    layout false

    def show
      @bid = params[:bid]
      @ask = params[:ask]

      @market        = current_market
      @markets       = Market.all.sort
      @market_groups = @markets.map(&:quote_unit).uniq

      @bids   = @market.bids
      @asks   = @market.asks
      @trades = @market.trades

      # default to limit order
      @order_bid = OrderBid.new ord_type: 'limit'
      @order_ask = OrderAsk.new ord_type: 'limit'

      set_member_data if current_user
      gon.jbuilder
      if current_user
        @notification = Notification.where(active: true).first

        @deposit_channels = DepositChannel.all
        @withdraw_channels = WithdrawChannel.all
        @currencies = Currency.all.sort
        @deposits = current_user.deposits
        @accounts = current_user.accounts.enabled
        @withdraws = current_user.withdraws
        @fund_sources = current_user.fund_sources
        @banks = Bank.all
 # byebug
        @ask_currency = Currency.find_by_code params[:ask]
        @bid_currency = Currency.find_by_code params[:bid]

        @ask_deposit =current_user.payment_addresses.find_by(:currency => @ask_currency.id)
        @bid_deposit =current_user.payment_addresses.find_by(:currency => @bid_currency.id)
      end
    end

    def market_withdraw

      @fund_sources = current_user.fund_sources
      @res = @fund_sources.where(:currency => params[:currency_id])
      @account = current_user.accounts.enabled.where(:currency => params[:currency_id]).first
      @currency = Currency.find_by_id params[:currency_id]
      render :json => {:info => @res, :sel_id => @account, :currency => @currency.key.pluralize }
    end

    def add_fundsource
      new_fund_source = current_user.fund_sources.new currency: params[:currency].downcase, uid: params[:uid], extra: params[:extra]

      if new_fund_source.save
        render json: new_fund_source, status: :ok
      else
        head :bad_request
      end

    end

    def remove_fundsource
      render json: fund_source.destroy, status: :ok
    end

    def default_fundsource
      account = current_user.accounts.with_currency(fund_source.currency).first
      account.update default_withdraw_fund_source_id: params[:id]

      head :ok

    end

    private

    def visible_market?
      redirect_to market_path(Market.first) if not current_market.visible?
    end

    def set_default_market
      cookies[:market_id] = @market.id
    end

    def set_member_data
      @member = current_user
      @orders_wait = @member.orders.with_currency(@market).with_state(:wait)
      @trades_done = Trade.for_member(@market.id, current_user, limit: 100, order: 'id desc')
    end

    def fund_source
      current_user.fund_sources.find(params[:id])
    end

  end
end
