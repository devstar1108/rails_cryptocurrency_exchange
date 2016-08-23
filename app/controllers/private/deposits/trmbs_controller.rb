module Private
  module Deposits
    class TrmbsController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
