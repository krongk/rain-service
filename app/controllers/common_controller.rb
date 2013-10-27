class CommonController < ApplicationController
  #因为pcall来电通是集成在其它网站上的，无法生成AuthenticityToken
  #http://my.eoe.cn/guanmac/archive/15421.html
  #rails4.0——ActionController::InvalidAuthenticityToken完美解决
  skip_before_filter :verify_authenticity_token

  #file upload ===============================
  def file_new
  end
  def file_upload
  	#render :text => params and return
    #upload file
    tmp = params[:file].tempfile
    unless (file_ext = params[:file].original_filename.split('.')).size > 1
      render :text => '错误的文件扩展名！<br/><a href="javascript: history.go(-1);">返回</a>'
      return
    end
    file_name = "#{Time.now.to_i}.#{file_ext.last.downcase}"
    file_path = File.join("public", "resource", params[:asset_type] || 'other')
    unless File.exist?(file_path)
      FileUtils.mkdir_p file_path
    end
    #public/resource/picture/2/1304543534.jpg
    file = File.join(file_path, file_name)
    FileUtils.cp tmp.path, file
    #FileUtils.rm tmp.path
    
    #/resource/phone/1304543534.xls
    puts "[#{file_ext}]"
    case file_ext.last.downcase
    when 'xls'
      s = Roo::Excel.new(file)
    when 'xlsx'
      s = Roo::Excelx.new(file)
    else
      raise "错误的文件扩展名！！"
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
  #file upload end===============================

  #phone call ===============================
  #参数：domain + ip + phone
  #验证：domain 域名对应真实网站的IP名单
  def pcall
    @phone_call = PhoneCall.new(phone_call_params)

    strs = []
    strs << "request.original_url: #{request.original_url}"
    strs << "request.remote_ip: #{request.remote_ip}"
    strs << "params: #{params}"
    puts "pcall....#{rand(43)}: #{params[:callback]}"
    #render text: strs.join("<br>\n") and return
    respond_to do |format|
      if @phone_call.save
        format.html { @str = strs.join("<br>\n") }
        format.json { render :json => @str, :callback => params[:callback] }
        format.js { render :json => 'ff', :callback => params[:callback] }
      else
        format.js { render :json => 'error', :status => 500 }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_call_params
      params.require(:phone_call).permit(:domain, :from_ip, :from_url, :from_phone, :is_processed, :note)
    end

end
