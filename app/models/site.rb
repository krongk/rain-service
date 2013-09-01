#encoding: utf-8
class Site < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :site_name
  validates_presence_of :user_id
  validate do
    (m = !self.site_name.to_s.strip.match(/^[0-9a-z.-]+$/)) &&
      errors.add(:base, "网站名称格式错误, 只能包含数字和字母和(.-)的组合")
  end
  validates_uniqueness_of :site_name, :case_sensitive => false
  
  has_many :site_comments, :dependent => :destroy
  #has_many :site_posts, :dependent => :destroy

  #
  after_create :increment_total_count
  after_destroy :decrement_total_count

  def increment_total_count
    Keystore.increment_value_for("user:#{self.user_id}:sites_count")
  end
  def decrement_total_count
    Keystore.decrement_value_for("user:#{self.user_id}:sites_count")
  end

end
