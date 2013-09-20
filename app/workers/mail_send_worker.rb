class MailSendWorker
  include Sidekiq::Worker

  def perform(cate, mail_tmp_id, to_emails)
    case cate
    when 'qq'
      QqMailer.marketing(mail_tmp_id, to_emails).deliver
    when 'gmail'
      Gmailer.marketing(mail_tmp_id, to_emails).deliver
    when 'mailgun'
      GunMailer.marketing(mail_tmp_id, to_emails).deliver
    else
      puts 'conflict cate'
    end
    puts "install mail sender: -> #{to_emails}"
    t = 120 + rand(300)
    sleep(t)
    puts "sleep...#{t}"
  end
end