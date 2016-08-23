module Private::Withdraws
  class GgcoinsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
