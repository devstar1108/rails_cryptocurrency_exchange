module Admin
  module Withdraws
    class TrmbsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Trmb'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_trmbs = @trmbs.with_aasm_state(:accepted).order("id DESC")
        @all_trmbs = @trmbs.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @trmb.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @trmb.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
