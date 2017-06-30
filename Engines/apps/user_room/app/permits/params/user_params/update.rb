class UserParams::Update < AuthorizeIt::PermittedParams::Base
  def permitted_params
    params = @params.require(:user).permit(
      :avatar, :raw_about,
      :login, :username, :email,

      :password, :password_confirmation,

      :vk_addr, :ok_addr, :tw_addr,
      :fb_addr, :ig_addr, :pt_addr,
      :gp_addr
    )

    if params[:password].blank? && params[:password_confirmation].blank?
      params = params.except(:password, :password_confirmation)
    end

    params
  end
end
