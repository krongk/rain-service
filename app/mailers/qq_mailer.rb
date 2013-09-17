class QqMailer < ActionMailer::Base
  default from: current_user.user_detail.fu_qmail_name

  QqMailer.smtp_settings = {
    address: "smtp.qq.com",
    port: 25,
    domain: ENV["DOMAIN_NAME"],
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: current_user.user_detail.fu_qmail_name,
    password: current_user.user_detail.fu_qmail_pwd
  }

  def marketing(mail_tmp, from_email, to_email)
    @mail_tmp = mail_tmp
    puts ".....qq mail deliver: #{QqMailer.from} -> #{to_email}"
    mail to: to_email
  end
end
