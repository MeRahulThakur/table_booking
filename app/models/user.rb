class User < ApplicationRecord
    before_save { self.email = email.downcase }
    has_many :bookings, dependent: :destroy
    validates :name, presence: true, 
                        length: {minimum: 3, maximum: 25}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
                        uniqueness: { case_sensitive: false },
                        length: { maximum: 105},
                        format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true, 
                        length: {minimum: 8}
    validates_presence_of :password_confirmation,presence: true, 
                        length: {minimum: 8}, :if => :password_digest_changed?

    has_secure_password
end