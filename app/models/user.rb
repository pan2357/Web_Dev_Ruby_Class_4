class User < ApplicationRecord
    has_many :posts
    validates :email, uniqueness: { case_sensitive: false }
end
