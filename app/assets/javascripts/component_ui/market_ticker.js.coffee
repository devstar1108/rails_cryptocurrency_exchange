window.MarketTickerUI = flight.component ->
  @attributes
    askSelector: '.ask .price'
    bidSelector: '.bid .price'
    lastSelector: '.last .price'
    priceSelector: '.price'

  @updatePrice = (selector, price, trend) ->
    selector.removeClass('text-up').removeClass('text-down').addClass(formatter.trend(trend))
    selector.html(formatter.fixBid(price))

  @refresh = (event, ticker) ->
    @updatePrice @select('askSelector'),  ticker.sell, ticker.sell_trend
    @updatePrice @select('bidSelector'),  ticker.buy,  ticker.buy_trend
    @updatePrice @select('lastSelector'), ticker.last, ticker.last_trend


    usd_amount = $('#mobile_usd_amount').val();

    full_ask_value = parseFloat(ticker.sell).toFixed(8);
    full_bid_value = parseFloat(ticker.buy).toFixed(8);
    ask_value = parseFloat(ticker.sell).toFixed(4);
    bid_value = parseFloat(ticker.buy).toFixed(4);

    $('#mobile_askSelector').text(ask_value);
    $('#mobile_askUSD').text(parseFloat(parseFloat(usd_amount) * ask_value).toFixed(3));

    $('#mobile-bid-div').removeClass('text-up').removeClass('text-down').addClass(formatter.trend(ticker.sell_trend));
    $('#mobile-ask-div').removeClass('text-up').removeClass('text-down').addClass(formatter.trend(ticker.buy_trend));

    $('#mobile_bidSelector').text(bid_value);
    $('#mobile_bidUSD').text(parseFloat(parseFloat(usd_amount) * bid_value).toFixed(3));

    $('#mobile_ask_smaller').text(parseFloat(full_ask_value - ask_value).toFixed(8).toString().substring(6, 10));
    $('#mobile_bid_smaller').text(parseFloat(full_bid_value - bid_value).toFixed(8).toString().substring(6, 10));

    $('#mobile_order_ask_price').text(formatter.fixBid(ask_value));
    $('#mobile_order_bid_price').text(formatter.fixBid(bid_value));

    if $('#order_ask_price').val() == ''
      $('#order_ask_price').val(formatter.fixBid(ticker.sell))
    if $('#order_bid_price').val() == ''
      $('#order_bid_price').val(formatter.fixBid(ticker.buy))

  @after 'initialize', ->
    @on document, 'market::ticker', @refresh
