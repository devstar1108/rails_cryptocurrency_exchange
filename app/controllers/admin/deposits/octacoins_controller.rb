module Admin
  module Deposits
    class OctacoinsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Octacoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24 * 365)
        @octacoins = @octacoins.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').page(params[:page]).per(20)
      end

      def update
        @octacoin.accept! if @octacoin.may_accept?
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
