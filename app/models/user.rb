class User < ApplicationRecord
    has_many :posts
    validates :email, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true
end
