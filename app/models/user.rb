class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :birth_day, :birth_month, :birth_year, :city, :state, :sex, :email, :password, :password_confirmation, :remember_me, :role

  has_many :blogs, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :user_trends, :dependent => :destroy
  has_many :trends, :through => :user_trends

  has_many :user_friends, :dependent => :destroy
  has_many :friends, :through => :user_friends

  has_many :groups, :dependent => :destroy

  has_many :user_likes
#  has_many :likes, :through => :user_likes

  has_many :comment_posts

  has_many :roles


  #scope :with_at_least, lambda {|number_of_bottles| where(:quantity_available.gte => number_of_bottles)}

  ROLES = %w[admin moderator standard]

  SEX = %w[male female]

  # def role_symbols
  #   [role.to_sym]
  # end

  def full_name
    [first_name,last_name].join(" ")
  end


  def birth_date
    [birth_month, birth_day, birth_year].join("/")
  end

  def address
    [city, state_id].join(",")
  end

  def age
    now = Time.now
    birthday = Date.civil(self.birth_year, self.birth_month, self.birth_day)
    age = (now.year - birthday.year) - (now.yday < birthday.yday ? 1 : 0)
    age;
  end

  define_index do
    indexes first_name
    indexes last_name
    indexes [first_name, last_name], :as => :full_name
  end



end
