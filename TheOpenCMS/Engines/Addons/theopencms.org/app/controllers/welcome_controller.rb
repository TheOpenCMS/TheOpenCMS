class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  layout 'app_theme/layouts/layout'
  def index; end
end
