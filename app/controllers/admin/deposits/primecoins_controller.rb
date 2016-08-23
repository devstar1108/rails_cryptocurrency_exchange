module Admin
  module Deposits
    class PrimecoinsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Primecoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24 * 365)
        @primecoins = @primecoins.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').page(params[:page]).per(20)
      end

      def update
        @primecoin.accept! if @primecoin.may_accept?
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
