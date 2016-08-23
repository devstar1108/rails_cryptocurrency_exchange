module Private::Withdraws
  class YbcoinsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
