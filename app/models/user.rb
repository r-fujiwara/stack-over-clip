class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts

  def self.authenticate(user_name, password)
    user = User.find_by(email: user_name)
    user.try(:valid_password?, password) ? user : nil
  end
end
