#encoding: utf-8
class MailItem < ActiveRecord::Base
  belongs_to :user
  has_many :mail_logs, :dependent => :destroy

  self.per_page = 30
  
  after_create :increment_total_count
  after_destroy :decrement_total_count

  scope :processed, -> (user_id) {where("user_id = ? AND is_processed != ?", user_id, 'n')}
  scope :no_processed, ->(user_id) {where("user_id = ? AND is_processed = ?", user_id, 'n')}
  # scope :created_before, ->(time) { where("created_at < ?", time) }
  
  validates_presence_of :email
  validate do
    (m = !self.email.to_s.strip.match(/^[\w-]+@([\w-]+\.)+[\w]+$/)) &&
      errors.add(:base, "邮件地址格式错误")
  end
  validates_uniqueness_of :email, :scope => [:user_id]

  def increment_total_count
    Keystore.increment_value_for("user:#{self.user_id}:mail_items_count")
  end
  def decrement_total_count
    Keystore.decrement_value_for("user:#{self.user_id}:mail_items_count")
  end

end
