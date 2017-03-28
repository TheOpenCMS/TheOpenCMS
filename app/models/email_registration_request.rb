class EmailRegistrationRequest < ActiveRecord::Base
  before_validation :build_uid, on: :create
  validates :email, presence: true

  private

  def build_uid
    self.uid = Digest::MD5.hexdigest("#{ Time.now }-#{ rand }")[0...7].downcase
  end
end
