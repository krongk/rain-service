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

      QqMailer.marketing(mail_tmp_id, to_emails).deliver
    when 'gmail'
      #Gmailer.marketing(mail_tmp_id, to_emails).deliver
    when 'mailgun'
      #GunMailer.marketing(mail_tmp_id, to_emails).deliver
    else
      puts 'conflict cate'
    end
    puts "install mail sender: -> #{to_emails}"
    t = 120 + rand(300)
    #sleep(t)
    puts "sleep...#{t}"
  end
end