module Admin
  module Statistic
    class RandomStatsController < BaseController
      def show
        @currencies_weighted_price = Currency.all.map(&:weekly_weighted_price)
      end
    end
  end
end
