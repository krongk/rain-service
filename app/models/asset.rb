class Asset < ActiveRecord::Base
  belongs_to :user

  has_attached_file :asset,
   :path => ":class/:attachment/:id/:basename.:extension"
  validates :asset, :attachment_presence => true

  validates_presence_of :asset_type, :bucket
  validate do 
  	!['phone', 'email', 'image', 'video'].include?(self.asset_type) &&
  	errors.add(:base, "Asset type 只接受 'phone', 'email', 'image', 'video'")
  end
  
end
