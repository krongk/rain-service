class QqMailer < ActionMailer::Base
  default from: ENV["QMAIL_USERNAME"]

  QqMailer.smtp_settings = {
    address: "smtp.qq.com",
    port: 25,
    domain: ENV["DOMAIN_NAME"],
    authentication: "plain",
    user_name: ENV["QMAIL_USERNAME"],
    password: ENV["QMAIL_PASSWORD"]
  }

  def marketing(mail_tmp_id, from_email, to_email)
    sleep(120 + rand(600))
    @mail_tmp = MailTmp.find(mail_tmp_id)
    mail to: to_email, subject: @mail_tmp.title
  end
end
