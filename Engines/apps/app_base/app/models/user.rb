class User < ApplicationRecord
  include ::RoleSystem
  include ::UserRoom::User
  include ::ActivePermits::User

  has_many :articles
end
