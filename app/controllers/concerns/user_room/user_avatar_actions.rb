# include UserRoom::UserAvatarActions
module UserRoom
  module UserAvatarActions

    # UserRoom::UserAvatarActions::ACTIONS_NAMES

    ACTIONS_NAMES = %w[
      avatar_crop_1x1
      avatar_rotate_left
      avatar_rotate_right
      avatar_delete
    ]

    def avatar_crop_1x1
      path = @user.avatar_crop_1x1(params)
      render json: { ids: { '@user-avatar--v1x1' => path + rnd_num } }
    end

    def avatar_rotate_left
      @user.avatar_rotate_left
      redirect_to :back
    end

    def avatar_rotate_right
      @user.avatar_rotate_right
      redirect_to :back
    end

    def avatar_delete
      @user.avatar_destroy!
      redirect_to :back
    end

    private

    def rnd_num
      "?#{ Time.now.to_i }"
    end
  end
end
