module Private::Withdraws
  class DashsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
