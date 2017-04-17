class UsersController < ApplicationController
  authorize_resource_name :user
  include ::UserRoom::UsersController
end
