#encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "雨服务@yufuwu.cn"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.marketing.subject
  #
  def marketing(mail_tmp, from_email, to_email)
    @mail_tmp = mail_tmp
    mail from: from_email, to: to_email, subject: @mail_tmp.title 
  end
end
