class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    validates :email, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true
end
