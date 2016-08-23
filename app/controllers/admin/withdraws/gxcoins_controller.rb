module Admin
  module Withdraws
    class GxcoinsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Gxcoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_gxcoins = @gxcoins.with_aasm_state(:accepted).order("id DESC")
        @all_gxcoins = @gxcoins.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @gxcoin.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @gxcoin.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
