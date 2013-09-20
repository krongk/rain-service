class QqMailer < ActionMailer::Base
  default from: UserAccount.get('qmail_name')

  QqMailer.smtp_settings = {
    address: "smtp.qq.com",
    port: 25,
    authentication: "plain",
    user_name: UserAccount.get('qmail_name'),
    password: UserAccount.get('qmail_password'),
    domain: UserAccount.get('domain'),
  }

  def marketing(mail_tmp_id, to_email)
    @mail_tmp = MailTmp.find(mail_tmp_id)
    mail to: to_email, subject: @mail_tmp.title
  end
end
