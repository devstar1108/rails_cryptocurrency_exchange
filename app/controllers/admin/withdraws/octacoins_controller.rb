module Admin
  module Withdraws
    class OctacoinsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Octacoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24 * 30)
        @one_octacoins = @octacoins.with_aasm_state(:accepted).order("id DESC")
        @all_octacoins = @octacoins.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @octacoin.almost_done?
          msg = @octacoin.recheck_and_withdraw
          redirect_to :back, notice: msg
        else
          @octacoin.process!
          redirect_to :back, notice: t('.notice')
        end
      end

      def destroy
        @octacoin.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
