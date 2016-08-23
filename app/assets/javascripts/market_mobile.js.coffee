#= require es5-shim.min
#= require es5-sham.min
#= require jquery
#= require jquery_ujs
#= require jquery.mousewheel
#= require jquery-timing.min
#= require jquery.nicescroll.min
#
#= require bootstrap
#= require bootstrap-switch.min
#
#= require moment
#= require bignumber
#= require underscore
#= require cookies.min
#= require flight.min
#= require pusher.min

#= require ./lib/sfx
#= require ./lib/notifier
#= require ./lib/pusher_connection

#= require ./market_mobile/highstock_mobile
#= require_tree ./highcharts/

#= require_tree ./helpers
#= require_tree ./component_mixin
#= require_tree ./component_data
#= require_tree ./component_ui
#= require_tree ./templates

#= require_self

#= require ./market_mobile/candlestick
#= require ./market_mobile/my_orders

$ ->
  window.notifier = new Notifier()

  BigNumber.config(ERRORS: false)

  HeaderUI.attachTo('header')
  AccountSummaryUI.attachTo('#account_summary')

  FloatUI.attachTo('.float')
  KeyBindUI.attachTo(document)

  PlaceOrderUI.attachTo('#bid_entry')
  PlaceOrderUI.attachTo('#ask_entry')
  OrderBookUI.attachTo('#order_book')
  DepthUI.attachTo('#depths_wrapper')

  MyOrdersUI_mobile.attachTo('#my_orders')
  MarketTickerUI.attachTo('#ticker')
  MarketSwitchUI.attachTo('#market_list_wrapper')
  MarketTradesUI_mobile.attachTo('#market_trades_wrapper')

  MarketData.attachTo(document)
  GlobalData.attachTo(document, {pusher: window.pusher})
  MemberData.attachTo(document, {pusher: window.pusher}) if gon.accounts

  CandlestickUI_mobile.attachTo('#candlestick')
  SwitchUI.attachTo('#range_switch, #indicator_switch, #main_indicator_switch, #type_switch')

  $('.panel-body-content').niceScroll
    autohidemode: true
    cursorborder: "none"

  $('#btc_amount').change (e) ->
    if $(this).val() == ""
      $(this).val(1)
    btc_cost_per_usd = $("#usd_amount").attr('placeholder')

    if $(this).val() * btc_cost_per_usd > 999999
      usd_amount = ($(this).val() * btc_cost_per_usd).toFixed(0)
    else
      usd_amount = ($(this).val() * btc_cost_per_usd).toFixed(2)
    $('#usd_amount').val(usd_amount)
    return

  $("#btc_amount").keydown (e) ->
    #limit length but allow backspace, delete and arrows
    if $(this).val().length >= parseInt( $(this).attr('maxlength') ) && (e.which != 13 && e.which != 46 && e.which != 37 && e.which != 39 && e.which != 8 && e.which != 0)
      return false


  $('#usd_amount').change (e) ->
    btc_cost_per_usd = $("#usd_amount").attr('placeholder')
    if $(this).val() == ""
      $(this).val(btc_cost_per_usd)
    $('#btc_amount').val( ($(this).val() / btc_cost_per_usd).toFixed(2) )
    return

  $("#usd_amount").keydown (e) ->
    #limit length but allow backspace, delete and arrows
    if $(this).val().length >= parseInt( $(this).attr('maxlength') ) && (e.which != 13 && e.which != 46 && e.which != 37 && e.which != 39 && e.which != 8 && e.which != 0)
      return false