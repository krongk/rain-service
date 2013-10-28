class PageController < ApplicationController
  layout 'page'
  #因为pcall来电通是集成在其它网站上的，无法生成AuthenticityToken
  #http://my.eoe.cn/guanmac/archive/15421.html
  #rails4.0——ActionController::InvalidAuthenticityToken完美解决
  skip_before_filter :verify_authenticity_token

  before_filter :set_access_control_headers
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Allow-Credentials'] = "true"
  end

  def index
  end

  #phone call ===============================
  #参数：domain + ip + phone
  #验证：domain 域名对应真实网站的IP名单
  def pcall
    @phone_call = PhoneCall.new()

    #parse params
    pram = params["_json"].gsub(/%5B/, '[').gsub(/%5D/, ']')
    #"phone_call[domain]=www.abc.com&phone_call[user_id]=29&phone_call[from_phone]=13688888888"
    @phone_call.domain     = $1 if pram =~ /phone_call\[domain\]=([^&=""]+)/
    @phone_call.user_id    = $1 if pram =~ /phone_call\[user_id\]=(\d+)/
    @phone_call.from_phone = $1 if pram =~ /phone_call\[from_phone\]=(\d+)/

    respond_to do |format|
      if @phone_call.save
        PhoneCallWorker.perform_async(@phone_call.id)
        format.html { }
        format.json { render :json => @phone_call, :callback => params[:callback] }
      else
        format.json { render :json => '信息提交失败', :status => 500 }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_call_params

      #params.require(:phone_call).permit(:domain, :user_id, :from_ip, :from_url, :from_phone, :is_processed, :note)
    end
end

