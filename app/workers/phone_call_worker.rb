class PhoneCallWorker
  include Sidekiq::Worker

  def perform(phone_call_id)
    puts "start send phone_call"
    @phone_call = PhoneCall.find(phone_call_id)
    return if @phone_call.nil?
    to_phone = @phone_call.try(:user).try(:user_detail).try(:mobile_phone)
    if to_phone.nil? || to_phone !~ /^(1(([35][0-9])|(47)|[8][0126789]))\d{8}$/i
      puts "pcall短信的接收方电话不对，请检查user.user_detail.mobile_phone"
      return
    end
    sms_content = "你有一个来自网站#{@phone_call.domain}的电话咨询请求： #{@phone_call.from_phone}, 请务必及时回复！"
    puts "sms send to #{ENV['SMS_BAO_USER']}, #{ENV['SMS_BAO_PASSWORD']} #{to_phone} : #{sms_content}"
    status_id = SmsBao.send(ENV['SMS_BAO_USER'], ENV['SMS_BAO_PASSWORD'], to_phone, sms_content)
    #write log
    sms_max_character_count = ENV['SMS_MAX_CHARACTER_COUNT']
    sms_max_character_count ||= 64
    billing_count = (sms_content.size/sms_max_character_count.to_f).ceil
    PhoneCallLog.create!(
          :user_id => @phone_call.user_id, 
          :phone_call_id => @phone_call.id, 
          :status => status_id,
          :billing_count => billing_count)
    #increment send count(per phone per send)
    Keystore.increment_value_for("user:#{@phone_call.user_id}:phone_call_send_count", 1)
    #update flag
    @phone_call.is_processed = "短信发送状态: #{status_id}"
    @phone_call.save
  end
end