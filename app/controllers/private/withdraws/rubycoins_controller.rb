module Private::Withdraws
  class RubycoinsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
