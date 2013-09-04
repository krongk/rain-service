class MailImportWorker
  include Sidekiq::Worker

  def perform(asset_id, file_ext)
    puts "start import phone items #{asset_id}"

    Asset.transaction do 
      asset = Asset.find(asset_id)
      file = asset.asset.url

      case file_ext
      when 'xls'
        s = Roo::Excel.new(file)
      when 'xlsx'
        s = Roo::Excelx.new(file)
      end
      s.default_sheet = s.sheets.first 
      
      #导入的字段为（邮件、姓名、来源、城市、地区、描述）
      index = 0
      1.upto(20000) do |row|
        val = []
        1.upto(10) do |col|
          val << s.cell(row, col).to_s.strip
        end
        #the last line?
        break if val.join.blank?
        
        email = val[0].to_s.strip
        next if email.nil? || !email.match(/^[\w-]+@([\w-]+\.)+[\w]+$/)

        e = MailItem.find_or_initialize_by_user_id_and_email(asset.user_id, email)
        e.user_id = asset.user_id
        e.name = val[1].to_s.strip
        e.source_name = val[2].to_s.strip
        e.city = val[3].to_s.strip
        e.area = val[4].to_s.strip
        e.description = val[5..-1].join.to_s.strip
        e.save!
        index +=  1
      end

      asset.destroy!
    end #end transaction
  end
end
