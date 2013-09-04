class MailSendWorker
  include Sidekiq::Worker

  def perform(mail_tmp_id, mail_item_ids)
    puts "start to send mail at #{Time.now}"
    mail_tmp = MailTmp.find(mail_tmp_id)
    MailItem.where(:id => mail_item_ids).each do |mail_item|
      status_id = MailBao.send(ENV['mail_BAO_USER'], ENV['mail_BAO_PASSWORD'], mail_item.mobile_mail, mail_tmp.content)
      #update flag
      mail_item.is_processed = mail_item.is_processed == 'n' ? "#{mail_tmp.id},#{status_id}" : "#{mail_tmp.id},#{status_id}|" + mail_item.is_processed
      mail_item.save!
      #write log
      mail_max_character_count = ENV['mail_MAX_CHARACTER_COUNT']
      mail_max_character_count ||= 64
      billing_count = (mail_tmp.content_size/mail_max_character_count.to_f).ceil
      mailLog.create!(
          :user_id => mail_item.user_id, 
          :mail_item_id => mail_item.id, 
          :mail_tmp_id => mail_tmp.id, 
          :status => status_id,
          :billing_count => billing_count)
      #increment billing count
      Keystore.increment_value_for("user:#{mail_item.user_id}:mail_billing_count", billing_count)
      #increment send count(per mail per send)
      Keystore.increment_value_for("user:#{mail_item.user_id}:mail_send_count", 1)
      puts "#{mail_item.id} - #{mail_item.is_processed} - #{billing_count}"
  end
  end
end