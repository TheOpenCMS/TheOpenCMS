# include ::UserRoom::ControllerAvatarActions
module UserRoom
  module ControllerAvatarActions

    AVATAR_ACTIONS_NAMES = %w[
      avatar_crop_1x1
      avatar_rotate_left
      avatar_rotate_right
      avatar_delete
    ]

    def avatar_crop_1x1
      crop_params = params[:crop].permit(:img_w, :x, :y, :w, :h).to_h.symbolize_keys
      path = @user.avatar_crop_1x1(crop_params)
      render json: { ids: { '.js-user_avatar-v1x1' => path } }
    end

    def avatar_rotate_left
      @user.avatar_rotate_left
      redirect_back fallback_location: root_path
    end

    def avatar_rotate_right
      @user.avatar_rotate_right
      redirect_back fallback_location: root_path
    end

    def avatar_delete
      @user.avatar_destroy!
      redirect_back fallback_location: root_path
    end
  end
end
