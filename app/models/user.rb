class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users_posts
  has_many :posts, through: :users_posts

  validates :email, {
    presence: true,
    uniqueness: true
  }

  validates :name, {
    presence: true,
    uniqueness: true
  }

  def self.authenticate(user_name, password)
    user = User.find_by(email: user_name)
    user.try(:valid_password?, password) ? user : nil
  end

end
