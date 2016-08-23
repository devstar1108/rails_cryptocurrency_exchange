module Admin
  module Withdraws
    class SatoshisController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Satoshi'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24 * 30)
        @one_satoshis = @satoshis.with_aasm_state(:accepted).order("id DESC")
        @all_satoshis = @satoshis.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @satoshi.almost_done?
          msg = @satoshi.recheck_and_withdraw
          redirect_to :back, notice: msg
        else
          @satoshi.process!
          redirect_to :back, notice: t('.notice')
        end
      end

      def destroy
        @satoshi.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
