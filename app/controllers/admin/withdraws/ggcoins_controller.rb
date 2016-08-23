module Admin
  module Withdraws
    class GgcoinsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Ggcoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_ggcoins = @ggcoins.with_aasm_state(:accepted).order("id DESC")
        @all_ggcoins = @ggcoins.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @ggcoin.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @ggcoin.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
