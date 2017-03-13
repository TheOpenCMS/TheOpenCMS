# This migration comes from user_room_engine (originally 200)
class UserRoomAddAvatar < ActiveRecord::Migration[5.0]
  def change
    add_attachment :users, :avatar
  end
end
