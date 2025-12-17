class User < ApplicationRecord
  has_many :orders
  validates :email, presence: true, uniqueness: true

    has_secure_password
    validates :email, presence: true, uniqueness: true


before_create :set_default_role

    def set_default_role
      self.role ||= "user"   # default user role
    end
end
