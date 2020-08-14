class User < ApplicationRecord
  has_many :exercises
  after_create :generate_authentication_token!

  has_secure_password

  private
  # Generate a session token
  def generate_authentication_token!
    puts "create authentication token"
    self.authentication_token = Digest::SHA1.hexdigest("#{Time.now}-#{self.id}-#{self.updated_at}")
    puts self.authentication_token
    self.save
  end
end
