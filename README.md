# AuthorizeIt

The Authorization Solution for TheOpenCMS

### Application controller

Close everything!

```ruby
class ApplicationController < ActionController::Base
  include ::AuthorizeIt::Controller
  rescue_from ::AuthorizeIt::NotAuthorized, with: :access_denied

  protect_from_forgery with: :exception

  before_action :authenticate_user!, if: :needs_authorization?
  before_action :authorize_action!,  if: :needs_authorization?
  before_action :set_resource!,      if: :needs_authorization?
  before_action :authorize_owner!,   if: :needs_authorization?

  private

  def needs_authorization?
    !devise_controller?
  end

  def access_denied
    redirect_back fallback_location: authorize_fallback_location,
      flash: {error: t('authorize_it.access_denied')}
  end
```

### A Controller. Open only permitted actions!

```ruby
class UsersController < ApplicationController
  authorize_resource_name :user

  skip_before_action :authenticate_user!, if: :skip_authenticate_user?
  skip_before_action :authorize_action!,  if: :skip_authorize_action?
  skip_before_action :set_resource!,      if: :skip_set_resource?
  skip_before_action :authorize_owner!,   if: :skip_authorize_owner?

  private

  def set_resource!
    user_id = params[:id] || params[:user_id]
    @user = ::User.where(login: user_id).first
  end

  protected

  def skip_authenticate_user?
    %w[index show].include?(action_name)
  end

  def skip_authorize_action?
    %w[index show edit update].include?(action_name)
  end

  def skip_set_resource?
    %w[index profile].include?(action_name)
  end

  def skip_authorize_owner?
    %w[index show profile].include?(action_name)
  end
end
```

### Remove `Strong Parameters` code from Controllers

Use `permitted_params`

```ruby
class UsersController < ApplicationController
  def update
    if @user.update(permitted_params)
      redirect_to @user, notice: 'User was updated'
    else
      render 'users/edit'
    end
  end
end
```

**app/permissions/params/users_controller/update_action.rb**

```ruby
class UsersController::UpdateAction < AuthorizeIt::PermittedParams::Base
  def permitted_params
    if @controller.current_user.admin?
      @params.require(:user).permit!
    else
      @params.require(:user).permit(:login, :username, :email)
    end
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
