class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  voiceless { include ::UserRoom::ApplicationController }
  # before_action :blog_admin_required!, except: %w[ index show ]
  # before_action :owner_required,       except: %w[ index show ]

  private
end
