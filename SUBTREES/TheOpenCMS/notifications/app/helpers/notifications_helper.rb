module NotificationsHelper
  def flash_class(level)
    case level.to_sym
      when :notice then "alert-info"
      when :errors then "alert-danger"
      when :error  then "alert-danger"
      when :alert  then "alert-warning"
      else "alert-success"
    end
  end
end
