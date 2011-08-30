class Post < ActiveRecord::Base

  belongs_to :user

  belongs_to :retrend_user, :class_name => "User", :foreign_key => :retrend_user_id

  belongs_to :post_content
  has_many :trends, :through => :post_content

  def delete_chars
    self.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")")
  end

  def trends_list
    self.trends.map(&:name).to_sentence
  end

end
