#encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "834700418@qq.com"

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
    @arr = [
      '443253.png',
      '1142708.png',
      '1276180.png',
      '311914.png',
      '945675.png',
      '1305158.png',
      '760222.png',
      '1186236.png',
      '1824626.png',
      '474268.png',
      '680954.png',
      '1409710.png',
      '363598.png',
      '1544674.png',
      '1831790.png',
      '629638.png',
      '1788068.png',
      '621757.png',
      '808787.png',
      '1056995.png',
      '1952451.png',
      '77557.png',
      '1698687.png',
      '2267.png',
      '1571768.png',
      '509212.png',
      '142914.png',
      '475711.png',
      '724026.png',
      '641960.png',
      '583905.png',
      '601175.png',
      '1752841.png',
      '424288.png',
      '1802619.png',
      '763902.png',
      '632277.png',
      '1249291.png',
      '384267.png',
      '850468.png',
      '1696523.png',
      '1390264.png',
      '435709.png',
      '1411120.png',
      '815536.png',
      '1793663.png',
      '607768.png',
      '1924994.png',
      '1638249.png',
      '416325.png'
    ]
    @img_path = "http://www.zxjj99.com/zuyus/#{@arr[rand(@arr.size)]}"
    mail from: from_email, to: to_email, subject: @mail_tmp.title 
  end
end
