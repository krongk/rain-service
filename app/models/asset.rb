class Asset < ActiveRecord::Base
  belongs_to :user

  before_create :init_paperclip

  scope :all_images, -> {where("asset_type = ?", 'image')}
  scope :all_files, -> {where("asset_type = ?", 'file')}
  scope :all_videos, -> {where("asset_type = ?", 'video')}

  has_attached_file :asset,
   :path => ":id-:basename.:extension"
  validates :asset, :attachment_presence => true

  validates_presence_of :asset_type
  validate do 
  	!['phone', 'mail', 'image', 'video', 'file'].include?(self.asset_type) &&
  	errors.add(:base, "Asset type 只接受 'phone', 'mail', 'image', 'video'")
  end
  
  def init_paperclip
    paperclip_options = {
      :qiniu_credentials => {
        :access_key => User.current_user.user_accounts.find{|a| a.name == 'qiniu_access_key'}.value,
        :secret_key => User.current_user.user_accounts.find{|a| a.name == 'qiniu_secret_key'}.value,
      },
      :bucket => User.current_user.user_accounts.find{|a| a.name == 'qiniu_bucket'}.value,
      :qiniu_host => User.current_user.user_accounts.find{|a| a.name == 'qiniu_host'}.value,
    }
    Paperclip::Attachment.default_options.merge!(paperclip_options)
  end

end
