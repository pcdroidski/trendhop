class Post < ActiveRecord::Base

  belongs_to :user

  has_many :post_trends
  has_many :trends, :through => :post_trends

  def delete_chars
    self.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")")
  end

  def trends_list
    self.trends.map(&:name).to_sentence
  end

end
