class WelcomeController < ApplicationController
  layout 'layouts/app_theme_frontend'

  skip_before_action :authenticate_user!, only: :index
  skip_before_action :authorize_action!,  only: :index
  skip_before_action :set_resource!,      only: :index
  skip_before_action :authorize_owner!,   only: :index
  skip_before_action :authorize_admin!,   only: :index

  def index; end
end
