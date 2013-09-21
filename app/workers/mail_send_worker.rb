class MailSendWorker
  include Sidekiq::Worker

  def perform(current_user_id, cate, mail_tmp_id, to_emails)
    case cate
    when 'qq'
      smtp_settings = {
        from: UserAccount.get(current_user_id, 'qmail_name'),
        user_name: UserAccount.get(current_user_id, 'qmail_name'),
        password: UserAccount.get(current_user_id, 'qmail_password'),
        domain: UserAccount.get(current_user_id, 'domain'),
      }
      QqMailer.smtp_settings.merge!(smtp_settings)
      puts "install QQmail: -> #{to_emails}"
      QqMailer.marketing(mail_tmp_id, to_emails).deliver
    when 'gmail'
      smtp_settings = {
        from: UserAccount.get(current_user_id, 'gmail_name'),
        user_name: UserAccount.get(current_user_id, 'gmail_name'),
        password: UserAccount.get(current_user_id, 'gmail_password'),
        domain: UserAccount.get(current_user_id, 'domain'),
      }
      Gmailer.smtp_settings.merge!(smtp_settings)
      puts "install Gmail: -> #{to_emails}"
      Gmailer.marketing(mail_tmp_id, to_emails).deliver
    when 'mailgun'
      smtp_settings = {
        from: UserAccount.get(current_user_id, 'mailgun_name'),
        user_name: UserAccount.get(current_user_id, 'mailgun_name'),
        password: UserAccount.get(current_user_id, 'mailgun_password'),
        domain: UserAccount.get(current_user_id, 'domain'),
      }
      GunMailer.smtp_settings.merge!(smtp_settings)
      puts "install mailgun: -> #{to_emails}"
      GunMailer.marketing(mail_tmp_id, to_emails).deliver
    else
      puts 'conflict cate'
    end
  end
end