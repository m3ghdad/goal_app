# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :session_token, presence: true, uniqueness: true

  validates :password, length: {minimum: 6, allow_nill: true}


  attr_reader :password

  befor_validation :ensure_session_toke

  def self.find_by_credentials(username, password)
    user = User.find_by(username)
    return nil if user.nil?
    user.is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = self.generate_session_token
    self.save!

    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private
  def ensure_session_toke
    self.session_token ||= self.generate_session_token
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end


end
