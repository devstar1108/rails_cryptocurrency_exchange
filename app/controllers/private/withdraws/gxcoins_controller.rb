module Private::Withdraws
  class GxcoinsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
