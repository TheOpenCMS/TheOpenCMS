class DeviseControllers::SessionsController < Devise::SessionsController
  layout 'user_room'

  def create_onetime_login_link
    _email  = params[:email].to_s.strip
    callback_path = params[:callback_path]

    user_for_login = User.where(email: _email).first

    if _email.blank? || !_email.match(/@/) || user_for_login.blank?
      return redirect_to :back, alert: 'Запрос не может быть выполнен'
    end

    if OnetimeLoginLink.where("email = ? AND created_at > ?", _email, 2.minutes.ago).first
      return redirect_to :back, alert: 'Запрос на одноразовый вход уже получен. Выполните вход или немного подождите'
    end

    log_req = OnetimeLoginLink.create(email: _email)
    DeviseMailer.onetime_login_request(log_req.id, callback_path).deliver_now
    redirect_to :back, alert: 'Запрос на одноразовый вход сформирован. Перейдите в свой почтовый ящик'
  end

  def activate_onetime_login_link
    uid = params[:uid]
    callback_path = params[:callback_path]

    log_req = OnetimeLoginLink.where(uid: uid).first

    unless log_req
      return redirect_to root_path, alert: 'Запрос на одноразовый вход не действителен'
    end

    log_req.update_attributes(
      uid: "created: #{ log_req.created_at } / activated: #{ Time.now }",
      created_at: 1.year.ago
    )

    user = User.where(email: log_req.email).first
    sign_in user

    next_page = callback_path.present? ? callback_path : cabinet_path
    redirect_to next_page, notice: 'Выполнен вход на сайт'
  end

  # POST /resource/sign_in
  def create
    respond_to do |format|
      format.html { super }
      format.json do
        self.resource = warden.authenticate(auth_options)
        sign_in(resource_name, resource) if resource
        render status: ( current_user ? 200 : 422 )
      end
    end
  end

  private

  def after_sign_out_path_for(resource)
    cookies[:previous_location] || super
  end

  def after_sign_in_path_for(resource)
    cabinet_path
  end
end
