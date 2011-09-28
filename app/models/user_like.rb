class UserLike < ActiveRecord::Base

  belongs_to :user
  belongs_to :likeable, :polymorphic => true, :dependent => :destroy
end
