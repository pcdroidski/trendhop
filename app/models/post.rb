class Post < ActiveRecord::Base

  belongs_to :user

  belongs_to :retrend_user, :class_name => "User", :foreign_key => :retrend_user_id

  belongs_to :post_content
  has_many :trends, :through => :post_content

  has_many :post_contents

  scope :no_retrends, :conditions => {:retrend => false}

  def delete_chars
    self.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")").delete(",").delete(".").delete("-")
  end

  def trends_list
    self.trends.map(&:name).to_sentence
  end

  def trend_hop
    array = []
    self.trends.each do |trend|
      trend.trend_hops.each do |hop|
        if !self.trends.include?(hop.trend) && !array.include?(hop.trend)
          array << hop.trend
        end
      end
    end
    return array
  end

end
