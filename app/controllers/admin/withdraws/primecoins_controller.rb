module Admin
  module Withdraws
    class PrimecoinsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Primecoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_primecoins = @primecoins.with_aasm_state(:accepted).order("id DESC")
        @all_primecoins = @primecoins.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @primecoin.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @primecoin.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
