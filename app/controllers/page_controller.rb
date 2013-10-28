class PageController < ApplicationController
  layout 'page'
  #因为pcall来电通是集成在其它网站上的，无法生成AuthenticityToken
  #http://my.eoe.cn/guanmac/archive/15421.html
  #rails4.0——ActionController::InvalidAuthenticityToken完美解决
  skip_before_filter :verify_authenticity_token

  def index
  end

  #phone call ===============================
  #参数：domain + ip + phone
  #验证：domain 域名对应真实网站的IP名单
  def pcall
    @phone_call = PhoneCall.new(phone_call_params)
    respond_to do |format|
      if @phone_call.save
        PhoneCallWorker.perform_async(@phone_call.id)
        format.html { }
        format.json { render :json => @str, :callback => params[:callback] }
        format.js { render :json => '信息提交成功', :callback => params[:callback] }
      else
        format.js { render :json => '信息提交失败', :status => 500 }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_call_params
      params.require(:phone_call).permit(:domain, :user_id, :from_ip, :from_url, :from_phone, :is_processed, :note)
    end
end
