class Asset < ActiveRecord::Base
  belongs_to :user

  #attr_accessible :file
  #has_attached_file :file, :path => ":class/:attachment/:id/:basename.:extension"
  has_attached_file :asset,
   :path => ":class/:attachment/:id/:basename.:extension"
  validates :asset, :attachment_presence => true

end
