class User < ApplicationRecord
  include ::RoleSystem
  include ::UserRoom::User
  include ::AuthorizeIt::User

  has_many :articles
end
