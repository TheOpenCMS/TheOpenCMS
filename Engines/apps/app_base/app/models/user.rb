class User < ApplicationRecord
  include ::RoleSystem
  include ::UserRoom::User

  has_many :articles
end
