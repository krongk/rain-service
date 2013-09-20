class GunMailer < ActionMailer::Base
  default from: ENV['MAILGUN_USERNAME']

  GunMailer.smtp_settings = {
    :port           => 587, 
    :address        => 'smtp.mailgun.org',
    :user_name      => ENV['MAILGUN_USERNAME'],
    :password       => ENV['MAILGUN_PASSWORD'],
    :domain         => ENV['DOMAIN'],
    :authentication => :plain,
  }

  def marketing(mail_tmp_id, to_email) 
    puts GunMailer.smtp_settings
    puts '..........................'
    @mail_tmp = MailTmp.find(mail_tmp_id)
    mail to: to_email, subject: @mail_tmp.title
  end
end


# #Mailgun
# ActionMailer::Base.smtp_settings = {
#   :port           => 587, 
#   :address        => 'smtp.mailgun.org',
#   :user_name      => ENV["MAILGUN_USERNAME"],
#   :password       => ENV["MAILGUN_PASSWORD"],
#   :domain         => 'yufuwu.cn',
#   :authentication => :plain,
# }
