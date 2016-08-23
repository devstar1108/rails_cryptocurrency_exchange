app.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state('deposits', {
      url: '/deposits'
      templateUrl: "/templates/funds/deposits.html"
    })
    .state('deposits.currency', {
      url: "/:currency"
      templateUrl: "/templates/funds/deposit_mobile.html"
      controller: 'DepositsController'
      currentAction: 'deposit'
    })
    .state('withdraws', {
      url: '/withdraws'
      templateUrl: "/templates/funds/withdraws.html"
    })
    .state('withdraws.currency', {
      url: "/:currency"
      templateUrl: "/templates/funds/withdraw_mobile.html"
      controller: 'WithdrawsController'
      currentAction: "withdraw"
    })
