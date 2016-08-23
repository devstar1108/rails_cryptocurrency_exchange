module Admin
  module Withdraws
    class RubycoinsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Rubycoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_rubycoins = @rubycoins.with_aasm_state(:accepted).order("id DESC")
        @all_rubycoins = @rubycoins.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @rubycoin.almost_done?
          msg = @rubycoin.recheck_and_withdraw
          redirect_to :back, notice: msg
        else
          @rubycoin.process!
          redirect_to :back, notice: t('.notice')
        end
      end

      def destroy
        @rubycoin.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
