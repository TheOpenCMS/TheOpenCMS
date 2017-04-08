module Paperclip
  module Interpolations
    def user_id attachment, style
      attachment.instance.id
    end
  end
end