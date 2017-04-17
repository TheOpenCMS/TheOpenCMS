class WelcomeController < ApplicationController
  layout 'app_theme/layouts/layout'

  skip_before_action :authenticate_user!, only: :index
  skip_before_action :set_resource!,      only: :index
  skip_before_action :authorize_owner!,   only: :index
  skip_before_action :authorize_admin!,   only: :index

  def index; end
end
