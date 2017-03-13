class UserRoomCredentials < ActiveRecord::Migration[5.1]
  def change
    create_table :credentials do |t|
      t.references :user

      t.string :provider
      t.string :uid

      t.string :expires_at
      t.text   :access_token
      t.text   :access_token_secret

      t.timestamps
    end
  end
end
