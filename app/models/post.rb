class Post < ActiveRecord::Base

  belongs_to :user

  belongs_to :retrend_user, :class_name => "User", :foreign_key => :retrend_user_id

  belongs_to :post_content
  has_many :trends, :through => :post_content

  has_many :post_contents

  has_many :comment_posts, :dependent => :destroy

  scope :no_retrends, :conditions => {:retrend => false}


  # you could put that in the product model
  #
  # class Product
  #   def self.favorites(user)
  #     # stuff
  #   end
  # end
  #
  # Product.favorites(@user)

  # class User
  #   has_many :products do
  #     def favorites
  #       proxy_owner.figure_out_favorites
  #     end
  #   end
  # end

#!!!!  scope :favorites lambda{|user, product|  where(:some_field => user.generate_favorites_list)} will work like this :    Product.where(:blah => test).favorites(@user, @product).order("blue")


  scope :friends, lambda {|user| where(:user_id => user.friends)}

  def delete_chars
    self.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")").delete(",").delete(".").delete("-")
  end

  def retrended?(user)
   # raise user.posts.inspect
    if self.user == user
      return 0
    elsif user.posts.where(:retrend_post_id => self.id).exists?
      return 1
    else
      return 2
    end
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

  define_index do
    indexes post_content.content
    indexes [user.first_name, user.last_name], :as => :user_name
    indexes trends(:name), :as => :trend
  end

end
