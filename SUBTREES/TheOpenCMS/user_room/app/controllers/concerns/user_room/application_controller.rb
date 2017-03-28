# include ::UserRoom::ApplicationController
module UserRoom
  module ApplicationController
    extend ActiveSupport::Concern

    included do
      before_action :define_user
    end # included

    private

    def define_user
      @root = ::User.try(:root)
      @user = current_user

      user_id = params[:user_id]

      if user_id
        @user = if ::FriendlyIdPack::Base.int? user_id
          ::User.find(user_id)
        else
          ::User.where(login: user_id).first
        end
      end
    end

  end # ApplicationController
end # UserRoom
