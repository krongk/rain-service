#encoding: utf-8
class PhoneItem < ActiveRecord::Base
  belongs_to :user
  has_many :sms_logs, :dependent => :destroy

  self.per_page = 1000

  scope :processed, -> {where("is_processed != ?", 'n')}
  scope :no_processed, -> {where(is_processed: 'n')}
  
  after_create :increment_total_count
  after_destroy :decrement_total_count

  validates_presence_of :mobile_phone
  validate do
    (m = !self.mobile_phone.to_s.strip.match(/^(1(([35][0-9])|(47)|[8][01236789]))\d{8}$/)) &&
      errors.add(:base, "手机号码格式错误")
  end
  validates_uniqueness_of :mobile_phone, :scope => [:user_id]

  def increment_total_count
    Keystore.increment_value_for("user:#{self.user_id}:phone_items_count")
  end
  def decrement_total_count
    Keystore.decrement_value_for("user:#{self.user_id}:phone_items_count")
  end
end
