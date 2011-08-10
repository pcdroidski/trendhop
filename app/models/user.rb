class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_night, :birth_day, :birth_month, :birth_year, :address, :sex, :email, :password, :password_confirmation, :remember_me

  has_many :blogs
  has_many :user_trends
  has_many :trends, :through => :user_trends


  def name
    [first_name,last_name].join(" ")
  end

  def birth_date
    [birth_month, birth_day, birth_year].join("/")
  end

end
