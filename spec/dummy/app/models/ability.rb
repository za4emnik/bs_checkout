class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    can :manage, :all if user.is_admin?

    can :manage, User, id: user.id
  end
end
