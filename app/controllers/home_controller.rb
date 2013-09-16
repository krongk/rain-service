class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end

  def sms
  	@sms_tmp = SmsTmp.new
    @phone_item = PhoneItem.new
    
    @phone_items_processed = current_user.phone_items.processed.page(params[:page]).order("updated_at DESC")
    @phone_items_no_processed = current_user.phone_items.no_processed.page(params[:page]).order("updated_at DESC")
  end

  def email  
    @mail_items_processed = current_user.mail_items.processed.page(params[:page]).order("updated_at DESC")
    @mail_items_no_processed = current_user.mail_items.no_processed.page(params[:page]).order("updated_at DESC")
  end

  def qq
  end

  #商贸通
  def commerce

  end
  #数据采集
  def data
  end

  #付费通
  def pay
  end
  
  def blog
  end

  def qq
  end

  def map
  end

  def fenlei
  end

  def forum
  end

  def weibo
  end

  def weixin
  end

  def qa
  end

  def wiki
  end

  def video
  end

  def mobile
  end

  def setting
    #render :text => params and return 
  end
end
