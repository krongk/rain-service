class MailSendWorker
  include Sidekiq::Worker

  def perform(mail_tmp_id, mail_item_ids)
    mail_tmp = MailTmp.find(mail_tmp_id)
    return if mail_tmp.nil? || mail_item_ids.empty?

    #fetch from email
    current_user = User.find(mail_tmp.user_id)
    from_email = current_user.user_detail.website
    unless from_email.nil?
      from_email = 'admin@' + from_email.sub(/^http(s)?(:)?(\/\/)?(www)?(\.)?/i, '')
    end
    from_email ||= current_user.email
    
    MailItem.where(:id => mail_item_ids).each do |item|
      current_user = User.find(item.user_id)

      puts "#{from_email} => #{item.email} start"
      UserMailer.marketing(mail_tmp, from_email, item.email).deliver
     
      status = 'y'
      item.is_processed = item.is_processed == 'n' ? "#{mail_tmp.id},#{status}" : "#{mail_tmp.id},#{status}|" + item.is_processed
      item.save!
      
      billing_count = 1
      MailLog.create!(
          :user_id => item.user_id, 
          :mail_item_id => item.id, 
          :mail_tmp_id => mail_tmp.id, 
          :status => status,
          :billing_count => billing_count)

      #increment billing count
      Keystore.increment_value_for("user:#{item.user_id}:mail_billing_count", billing_count)

      #increment send count(per phone per send)
      Keystore.increment_value_for("user:#{item.user_id}:mail_send_count", 1)
      puts "down"
    end
  end
end