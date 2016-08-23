module Private
  module Deposits
    class TethersController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
