class MailSendWorker
  include Sidekiq::Worker

  def perform(mail_tmp_id, mail_item_ids)
    email_tmp = MailTmp.find_by_id(mail_tmp_id)
    mail_item_ids = mail_item_ids || []
    return email_tmp.nil? || mail_item_ids.empty?

    #fetch from email
    from_email = current_user.user_detail.domain
    from_email = 'admin@' + current_user.user_detail.domain unless from_email.nil?
    from_email ||= current_user.email
    
    MailItem.where(:id => mail_item_ids).each do |item|
      current_user = User.find(item.user_id)

      UserMailer.marketing(email_tmp, from_email, item.email).deliver
     
      status = 'y'
      item.is_processed = item.is_processed == 'n' ? "#{email_tmp.id},#{status}" : "#{email_tmp.id},#{status}|" + item.is_processed
      item.save!
      
      billing_count = 1
      MailLog.create!(
          :user_id => item.user_id, 
          :mail_item_id => item.id, 
          :mail_tmp_id => email_tmp.id, 
          :status => status,
          :billing_count => billing_count)

      #increment billing count
      Keystore.increment_value_for("user:#{item.user_id}:mail_billing_count", billing_count)

      #increment send count(per phone per send)
      Keystore.increment_value_for("user:#{item.user_id}:mail_send_count", 1)
    end
  end
end