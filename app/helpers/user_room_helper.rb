module UserRoomHelper
  def default_user_avatar(user, opts = {})
    klass  = opts[:class]
    width  = opts[:width]  || 100
    height = opts[:height] || 100
    id = Digest::SHA256.hexdigest(user.login)

    content_tag :canvas, nil, class: klass, width: width, height: height, 'data-jdenticon-hash' => id
  end
end
