module UserRoomLogger
  class << self
    DEV_LOGGING = false

    def delay_time
      5.seconds
    end

    # UserRoomLogger.new_user_created(user_id)
    def new_user_created(user_id)
      log_with do
        DeviseMailer.delay_for(delay_time).new_user_created(user_id)
      end
    end

    private

    def logging?
      return DEV_LOGGING if Rails.env.development?
      true
    end

    def log_with
      if logging?
        begin;
          yield
        rescue; end;
      else
        p '*'*50
        p 'Log action completed'
        p'*'*50
      end
    end
  end
end