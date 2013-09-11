class SitePage < ActiveRecord::Base
  belongs_to :user
  belongs_to :site

  before_validation :assign_short_id,
    :on => :create
  validates_presence_of :user_id, :site_id, :short_id
  validates_uniqueness_of :short_id, :scope => [:site_id]

  def assign_short_id
    #user manually assign
    return if !self.short_id.nil? && 
    SitePage.where(user_id: self.user_id, site_id: self.site_id, short_id: self.short_id).empty?
    #auto assign
    self.short_id = ShortId.new(self.class).generate
  end
end
