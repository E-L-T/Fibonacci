class User < ApplicationRecord
  include Clearance::User
  validates :email, :password, presence: true
end
