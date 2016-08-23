module Admin
  module Withdraws
    class YbcoinsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Ybcoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_ybcoins = @ybcoins.with_aasm_state(:accepted).order("id DESC")
        @all_ybcoins = @ybcoins.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @ybcoin.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @ybcoin.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
