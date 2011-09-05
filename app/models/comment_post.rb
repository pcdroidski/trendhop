class CommentPost < ActiveRecord::Base
  belongs_to :post
  
  belongs_to :user, :foreign_key => :commenter
  
end
