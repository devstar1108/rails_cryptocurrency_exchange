module Admin
  module Withdraws
    class DashsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Dash'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_dashs = @dashs.with_aasm_state(:accepted).order("id DESC")
        @all_dashs = @dashs.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @dash.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @dash.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
