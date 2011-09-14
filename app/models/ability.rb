class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  #guest user
  # raise user.inspect
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, Comment
      can :update, Comment do |comment|
        comment.try(:user) == user || user.role == 'moderator'
      end
      if user.role == 'standard'
        can :update, User do |me|
          me == user
        end
        can :create, Post
        can :udpate, Post do |post|
          post.try(:user) == user
        end
        can :create, Blog
        can :update, Blog do |blog|
          blog.try(:user) == user
        end
      end
    end
  end

end