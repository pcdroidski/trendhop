class Blog < ActiveRecord::Base

  belongs_to :user

  has_many :blog_trends
  has_many :trends, :through => :blog_trends

  def delete_chars
    self.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")")
  end

end
