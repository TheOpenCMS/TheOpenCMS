# This migration comes from user_room_engine (originally 400)
class UserRoomEmailRegistrationRequest < ActiveRecord::Migration[5.0]
  def change
    create_table :email_registration_requests do |t|
      t.string  :uid,    default: ''
      t.string  :email,  default: ''

      t.timestamps null: false
    end
  end
end
