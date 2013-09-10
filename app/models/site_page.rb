class SitePage < ActiveRecord::Base
  belongs_to :user
  belongs_to :site

  validates_presence_of :user_id, :site_id, :short_id
  validates_uniqueness_of :short_id, :scope => [:site_id]
end
