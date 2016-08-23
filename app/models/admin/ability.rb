module Admin
  class Ability
    include CanCan::Ability

    def initialize(user)
      return unless user.admin?

      can :read, Order
      can :read, Trade
      can :read, Proof
      can :update, Proof
      can :manage, Document
      can :manage, Member
      can :manage, Ticket
      can :manage, IdDocument
      can :manage, TwoFactor

      can :menu, Deposit
      can :manage, ::Deposits::Bank
      can :manage, ::Deposits::Satoshi
      can :manage, ::Deposits::Litecoin
      can :manage, ::Deposits::Octacoin
      can :manage, ::Deposits::Dogecoin
      can :manage, ::Deposits::Dashcoin
      can :manage, ::Deposits::Ripple
      can :manage, ::Deposits::Ethereum
      can :manage, ::Deposits::Bitsharesx
      can :manage, ::Deposits::Tether
      can :manage, ::Deposits::Dash
      can :manage, ::Deposits::Trmb
      can :manage, ::Deposits::Rubycoin
      can :manage, ::Deposits::Ybcoin
      can :manage, ::Deposits::Primecoin
      can :manage, ::Deposits::Gxcoin
      can :manage, ::Deposits::Ggcoin

      can :menu, Withdraw
      can :manage, ::Withdraws::Bank
      can :manage, ::Withdraws::Satoshi
      can :manage, ::Withdraws::Litecoin
      can :manage, ::Withdraws::Octacoin
      can :manage, ::Withdraws::Dogecoin
      can :manage, ::Withdraws::Dashcoin
      can :manage, ::Withdraws::Ripple
      can :manage, ::Withdraws::Ethereum
      can :manage, ::Withdraws::Bitsharesx
      can :manage, ::Withdraws::Tether
      can :manage, ::Withdraws::Dash
      can :manage, ::Withdraws::Trmb
      can :manage, ::Withdraws::Rubycoin
      can :manage, ::Withdraws::Ybcoin
      can :manage, ::Withdraws::Primecoin
      can :manage, ::Withdraws::Gxcoin
      can :manage, ::Withdraws::Ggcoin
    end
  end
end
