#encoding: utf-8
class SitePost < ActiveRecord::Base
  include ActionView::Helpers
  belongs_to :user
  belongs_to :site

  liquid_methods :id, :title, :content, :update_at, :formated_content

  validates_presence_of :user_id, :site_id, :cate_id, :title, :content

  #cate
  POST_CATES = ['新闻', '专题', '服务项目', '关于我们', '联系我们']
  def self.cates
  	POST_CATES
  end

  def self.cate_id(name)
  	POST_CATES.index(name)
  end

  #count
  after_create :increment_total_count, :send_to_qzone
  after_destroy :decrement_total_count

  def increment_total_count
    Keystore.increment_value_for("site:#{self.site_id}:site_posts_count")
  end
  def decrement_total_count
    Keystore.decrement_value_for("site:#{self.site_id}:site_posts_count")
  end

  def send_to_qzone

  end
  
end
