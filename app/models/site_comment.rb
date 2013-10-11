#encoding: utf-8
class SiteComment < ActiveRecord::Base
  belongs_to :site
  liquid_methods :id, :name, :mobile_phone, :email, :content
  attr_accessor :redirect_url

  validates_presence_of :content

  #count
  after_create :increment_total_count
  after_destroy :decrement_total_count

  def increment_total_count
    Keystore.increment_value_for("site:#{self.site_id}:site_comments_count")
  end
  def decrement_total_count
    Keystore.decrement_value_for("site:#{self.site_id}:site_comments_count")
  end
end
