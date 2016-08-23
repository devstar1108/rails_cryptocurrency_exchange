class PagesController < ApplicationController
  layout 'pages'

  def fees
    @markets = Market.all
    @currencies = Currency.all
    @deposit_channels = DepositChannel.all
    @withdraw_channels = WithdrawChannel.all
  end
  def aboutus

  end

  def terms

  end
end
