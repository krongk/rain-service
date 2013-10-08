class Keystore < ActiveRecord::Base
	def self.get(key)
    Keystore.find_by_key(key)
  end

  def self.put(key, value)
    ks = Keystore.find_or_create_by_key(key)
    ks.value = ks.value + value
    ks.save!
    true
  end

  def self.increment_value_for(key, amount = 1)
    self.incremented_value_for(key, amount)
  end

  def self.decrement_value_for(key, amount = -1)
    self.incremented_value_for(key, amount)
  end


  def self.incremented_value_for(key, amount = 1)
    new_value = nil

    Keystore.transaction do
      ks = Keystore.find_or_create_by_key(key)
      ks.value = ks.value.to_i + amount
      ks.save!
      new_value = self.value_for(key)
    end

    return new_value
  end

  

  def self.value_for(key)
    self.get(key).try(:value)
  end
end


#useage:
#    Keystore.increment_value_for("user:#{self.user_id}:comments_posted")

=begin
  :phone_items_count
  :sms_tmps_count
  :sms_logs_count
  :sms_billing_count
  :sms_send_count

  :mail_items_count
  :mail_tmps_count
  :mail_logs_count
  :mail_billing_count
  :mail_send_count

  :sites_count
  :site_posts_count
  
=end