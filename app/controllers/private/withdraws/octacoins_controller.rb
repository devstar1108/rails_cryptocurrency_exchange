module Private::Withdraws
  class OctacoinsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
