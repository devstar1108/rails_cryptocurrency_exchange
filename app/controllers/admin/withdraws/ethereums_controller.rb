module Admin
  module Withdraws
    class EthereumsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Ethereum'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_ethereums = @ethereums.with_aasm_state(:accepted).order("id DESC")
        @all_ethereums = @ethereums.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @ethereum.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @ethereum.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
