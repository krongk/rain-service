class MailSendWorker
  include Sidekiq::Worker

  def perform(cate, mail_tmp, from_email, to_email)
    case cate
    when 'qq'
      QqMailer.marketing(mail_tmp, from_email, to_email).deliver
    when 'gmail'
      Gmailer.marketing(mail_tmp, from_email, to_email).deliver
    else
      puts 'conflict cate'
    end
    puts "install mail sender: #{from_email} -> #{to_email}"
    sleep(120 + rand(600))
  end
end