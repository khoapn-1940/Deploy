class Ability
  include CanCan::Ability
  def initialize user
    alias_action :update, :destroy, to: :modify
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.user?
      user_role user
    else
      can :read, TourDetail
      can :create, User
      can :login, User
    end
  end

  def user_role user
    can :read, TourDetail
    can [:read, :update], User
    can [:create, :destroy], Booking, user_id: user.id
    can [:create, :destroy], Review, user_id: user.id
    can [:create, :destroy], Like, user_id: user.id
    can :create, Payment
    can :create, Rating
    # can [:create], Payment
    can :logout, User
    can :view_information, User
    can :view_my_booking, User
    can :view_my_review, User
    can :view_tour_detail, User
    # can :rating, Rating
    # can :booking, Booking
    # can :comment, Comment
    # can :like_comment, Like
    # can :pay, Payment
    can :be, User
  end
end
