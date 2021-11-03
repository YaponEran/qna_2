# frozen_string_literal: true

class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)

    @user = user
      # user ||= User.new # guest user (not logged in)
      if user
        user.admin? ? admin_abilities : user_abilities
      else
        guest_abilities
      end

    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer], user: user
    can :destroy, [Question, Answer], user: user
    can [:vote_up, :vote_down], [Question, Answer] do |resource|
      resource.votes.exists?(user: user)
    end

    can :choose_best, Answer, user: user
    can :manage, Link,  user: user 
  end
end
