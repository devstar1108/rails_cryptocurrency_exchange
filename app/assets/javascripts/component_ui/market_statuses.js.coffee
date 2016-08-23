window.MarketStatusesUI = flight.component ->
  @attributes
    table: 'tbody'

  @updateMarket = (select, ticker) ->
    trend = formatter.trend ticker.last_trend
    select.find('td.vol').text("#{ticker.volume} #{ticker.base_unit}")
    select.find('td.high').text(ticker.high)
    select.find('td.low').text(ticker.low)
    select.find('td.sell').removeClass('text-up').removeClass('text-down').addClass(formatter.trend(ticker.sell_trend)).html(formatter.fixBid(ticker.sell))
    select.find('td.buy').removeClass('text-up').removeClass('text-down').addClass(formatter.trend(ticker.buy_trend)).html(formatter.fixBid(ticker.buy))
    select.find('td.price').removeClass('text-up').removeClass('text-down').addClass(formatter.trend(ticker.last_trend)).html(formatter.fixBid(ticker.last))

    p1 = parseFloat(ticker.open)
    p2 = parseFloat(ticker.last)
    trend = formatter.trend(p1 <= p2)
    select.find('td.change').html("<span class='#{trend}'>#{formatter.price_change(p1, p2)}%</span>")

  @refresh = (event, data) ->
    table = @select('table')
    for ticker in data.tickers
      @updateMarket table.find("tr#market-list-#{ticker.market}"), ticker.data

    table.find("tr#market-list-#{gon.market.id}").addClass 'highlight'

  @after 'initialize', ->
    @on document, 'market::tickers', @refresh

    @select('table').on 'click', 'tr', (e) ->
      unless e.target.nodeName == 'I'
        window.location.href = window.formatter.market_url($(@).data('market'))