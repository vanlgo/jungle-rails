class User < ActiveRecord::Base

  has_secure_password
  validates :password, length: {minimum: 8}
  validates_presence_of :password_confirmation

  validates :email, presence: true,  uniqueness: { case_sensitive: false }

  validates_presence_of :first_name
  validates_presence_of :last_name
end
