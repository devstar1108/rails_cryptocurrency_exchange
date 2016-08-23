module Private::Withdraws
  class TrmbsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
