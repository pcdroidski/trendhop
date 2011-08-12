class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  #guest user

    if user.role? :admin
      can :manage, :all
    # else
    #   can :read, :all
    #   can :create, Comment
    #   can :update, Comment do |comment|
    #     comment.try(:user) == user 
    #   end
    end
    
    if user.role?(:standard)
      can :read, :all
      can :create, Blog
      can :update, Blog do |blog|
   #     raise "#{blog.try(:user).inspect} #{user.inspect}"
         blog.try(:user) == user
      end
      
    end
  end

end