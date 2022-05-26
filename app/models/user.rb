class User < ActiveRecord::Base

  has_secure_password
  validates :password, length: {minimum: 8}
  validates_presence_of :password_confirmation

  validates :email, presence: true,  uniqueness: { case_sensitive: false }

  validates_presence_of :first_name
  validates_presence_of :last_name
  before_save :downcase_fields

  def downcase_fields
    self.email.downcase!
  end

  def self.authenticate_with_credentials(email, password)
    squished_email = email.squish.downcase
    user = User.find_by_email(squished_email)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
