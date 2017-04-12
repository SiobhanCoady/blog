class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # if user.is_admin?
    #   can :manage, :all
    # end

    can [:edit, :update, :destroy], Post do |post|
      post.user == user
    end

    can [:edit, :update], User do |u|
      u == user
    end

  end

end
