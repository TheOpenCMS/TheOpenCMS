class UserRoomAdditionalFields < ActiveRecord::Migration[5.1]
  def change
      add_column :users, :login,    :string, default: ''
      add_column :users, :username, :string, default: ''

      add_column :users, :raw_about, :text
      add_column :users, :about,     :text

      add_column :users, :vk_addr, :string, default: '' # vk.com
      add_column :users, :ok_addr, :string, default: '' # odnoklassniki
      add_column :users, :tw_addr, :string, default: '' # twitter
      add_column :users, :fb_addr, :string, default: '' # facebook
      add_column :users, :gp_addr, :string, default: '' # G+
      add_column :users, :ig_addr, :string, default: '' # instagramm
      add_column :users, :pt_addr, :string, default: '' # pinterest
      add_column :users, :yt_addr, :string, default: '' # youtube
      add_column :users, :vm_addr, :string, default: '' # vimeo
      add_column :users, :sh_addr, :string, default: '' # slideshare
  end
end
