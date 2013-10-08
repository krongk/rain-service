class MailTmp < ActiveRecord::Base
  self.per_page = 50
  belongs_to :user

  validates_presence_of :title, :content

  after_create :increment_total_count
  after_destroy :decrement_total_count

  def increment_total_count
    Keystore.increment_value_for("user:#{self.user_id}:mail_tmps_count")
  end
  def decrement_total_count
    Keystore.decrement_value_for("user:#{self.user_id}:mail_tmps_count")
  end
end
