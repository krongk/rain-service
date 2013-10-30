class PhoneCall < ActiveRecord::Base
  belongs_to :user

  after_create :increment_total_count
  after_destroy :decrement_total_count

  validates_presence_of :from_phone
  validate do
    (m = !self.from_phone.to_s.strip.match(/^(1(([35][0-9])|(47)|[8][01236789]))\d{8}$/)) &&
      errors.add(:base, "手机号码格式错误")
  end

  def increment_total_count
    Keystore.increment_value_for("user:#{self.user_id}:phone_calls_count")
  end
  def decrement_total_count
    Keystore.decrement_value_for("user:#{self.user_id}:phone_calls_count")
  end

end
