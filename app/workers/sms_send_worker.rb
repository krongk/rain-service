class SmsSendWorker
  include Sidekiq::Worker

  def perform(sms_tmp_id, phone_item_ids)
    puts "start to send sms at #{Time.now}"
    sms_tmp = SmsTmp.find(sms_tmp_id)
    PhoneItem.where(:id => phone_item_ids).each do |phone_item|
	    status_id = SmsBao.send(ENV['SMS_BAO_USER'], ENV['SMS_BAO_PASSWORD'], phone_item.mobile_phone, sms_tmp.content)
	    #update flag
	    phone_item.is_processed = phone_item.is_processed == 'n' ? "#{sms_tmp.id},#{status_id}" : "#{sms_tmp.id},#{status_id}|" + phone_item.is_processed
	    phone_item.save!
	    #write log
	    sms_max_character_count = ENV['SMS_MAX_CHARACTER_COUNT']
	    sms_max_character_count ||= 64
	    billing_count = (sms_tmp.content_size/sms_max_character_count.to_f).ceil
	    SmsLog.create!(
	    		:user_id => phone_item.user_id, 
	    		:phone_item_id => phone_item.id, 
	    		:sms_tmp_id => sms_tmp.id, 
	    		:status => status_id,
	    		:billing_count => billing_count)
	    #increment billing count
	    Keystore.increment_value_for("user:#{phone_item.user_id}:sms_billing_count", billing_count)
	    #increment send count(per phone per send)
	    Keystore.increment_value_for("user:#{phone_item.user_id}:sms_send_count", 1)
	    puts "#{phone_item.id} - #{phone_item.is_processed} - #{billing_count}"
	end
  end
end