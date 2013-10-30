class PageController < ApplicationController
  layout 'page'
  #因为pcall来电通是集成在其它网站上的，无法生成AuthenticityToken
  #http://my.eoe.cn/guanmac/archive/15421.html
  #rails4.0——ActionController::InvalidAuthenticityToken完美解决
  skip_before_filter :verify_authenticity_token

  def index
  end

  #phone call ===============================
  def pcall
    # # {"callback"=>"jQuery19008977521306369454_1383101029441", "\"phone_call"=>{"domai
    # # n"=>"www.abc.com"}, "phone_call"=>{"user_id"=>"29", "from_phone"=>"13688888888\"
    # # "}, "_"=>"1383101029442", "controller"=>"page", "action"=>"pcall", "page"=>{}}
    @phone_call = PhoneCall.new(phone_call_params)

    respond_to do |format|
      if @phone_call.save
        #发送短信通知
        @phone_call.reload
        PhoneCallWorker.perform_async(@phone_call.id)
        format.html { }
        format.js { render :json => @phone_call, :callback => params[:callback] }
      else
        format.js { render :json => "提交失败", :callback => params[:callback] }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_call_params
      params.require(:phone_call).permit(:domain, :user_id, :from_ip, :from_url, :from_phone, :is_processed, :note)
    end
end

