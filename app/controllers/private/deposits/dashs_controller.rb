module Private
  module Deposits
    class DashsController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
