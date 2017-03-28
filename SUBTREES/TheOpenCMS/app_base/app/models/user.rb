class User < ApplicationRecord
  include ::RoleSystem
  include ::UserRoom::User
end
