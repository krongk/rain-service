class QqMailer < ActionMailer::Base
  default from: ENV['QMAIL_USERNAME']

  QqMailer.smtp_settings = {
    address: "smtp.qq.com",
    port: 25,
    authentication: "plain",
    user_name: ENV['QMAIL_USERNAME'],
    password: ENV['QMAIL_PASSWORD'],
    domain: ENV['DOMAIN'],
  }

  def marketing(mail_tmp_id, to_email)
    puts '...........................'
    puts QqMailer.smtp_settings
    @mail_tmp = MailTmp.find(mail_tmp_id)
    mail to: to_email, subject: @mail_tmp.title
  end
end
