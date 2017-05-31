class Credential < ActiveRecord::Base
  belongs_to :user

  validates_presence_of   :uid, :user_id, :provider
  validates_uniqueness_of :uid, scope: :provider
end
