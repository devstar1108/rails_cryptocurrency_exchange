module Admin
  module Withdraws
    class BitsharesxsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Bitsharesx'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_bitsharesxs = @bitsharesxs.with_aasm_state(:accepted).order("id DESC")
        @all_bitsharesxs = @bitsharesxs.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @bitsharesx.almost_done?
          msg = @bitsharesx.recheck_and_withdraw
          redirect_to :back, notice: msg
        else
          @bitsharesx.process!
          redirect_to :back, notice: t('.notice')
        end
      end

      def destroy
        @bitsharesx.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
