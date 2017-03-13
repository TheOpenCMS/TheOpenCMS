class UserRoomOnetimeLoginLink < ActiveRecord::Migration[5.0]
  def change
    create_table :onetime_login_links do |t|
      t.string  :uid,    default: ''
      t.string  :email,  default: ''

      t.timestamps null: false
    end
  end
end
