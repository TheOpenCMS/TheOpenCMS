class User < ApplicationRecord
  include ::RoleSystem
  include ::UserRoom::User
  include ::AuthorizeIt::Ownership::User

  has_many :articles
end
