module BsCheckout
  class Ability
    include CanCan::Ability

    def initialize(user)
      alias_action :read, :update, :destroy, to: :all_excluding_create

      user ||= User.new

      can :manage, Order, user_id: user.id
      can :create, OrderItem
      can :all_excluding_create, OrderItem do |order_item|
        order_item.order.user_id == user.id
      end
    end
  end
end
