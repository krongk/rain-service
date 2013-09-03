class PhoneImportWorker
  include Sidekiq::Worker

  def perform(excel_url, file_ext)

    case file_ext
    when 'xls'
      s = Roo::Excel.new(excel_url)
    when 'xlsx'
      s = Roo::Excelx.new(excel_url)
    end
    s.default_sheet = s.sheets.first 

    
    #导入的字段为（手机号、姓名、来源、城市、地区、描述）
    index = 0
    1.upto(20000) do |row|
      val = []
      1.upto(6) do |col|
        val << s.cell(row, col).to_s.strip
      end
      #the last line?
      break if val.join.blank?
   
      phone = val[0].to_s.sub(/^(\d{11}).*/, '\1').strip
      p = PhoneItem.find_or_initialize_by_mobile_phone(phone)
 
      next if phone.nil? || 
       (phone !~ /^[\w-]+@([\w-]+\.)+[\w]+$/ &&
       phone !~ /^(1(([35][0-9])|(47)|[8][01236789]))\d{8}$/)

      p.user_id = current_user.id
      p.name = val[1]
      p.source_name = val[2]
      p.city = val[3]
      p.area = val[4]
      p.description = val[-1]
      p.save!
      index +=  1
    end
  end
  end
end