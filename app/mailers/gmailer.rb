class Gmailer < ActionMailer::Base
  default from: UserAccount.get('gmail_name')

  Gmailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: UserAccount.get('gmail_name'),
    password: UserAccount.get('gmail_password'),
    domain: UserAccount.get('domain')
  }

  def marketing(mail_tmp_id, to_email)
    puts Gmailer.smtp_settings
    @mail_tmp = MailTmp.find(mail_tmp_id)
    mail to: to_email, subject: @mail_tmp.title
  end
end
