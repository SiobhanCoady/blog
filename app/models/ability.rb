class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    end

    can [:edit, :update, :destroy], Post do |post|
      post.user == user
    end

    can [:edit, :update, :edit_password, :update_password], User do |u|
      u == user
    end

    can :destroy, Comment do |comment|
      comment.user == user
      comment.post.user == user
    end

  end

end
