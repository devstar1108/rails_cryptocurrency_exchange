module Private::Withdraws
  class TethersController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
