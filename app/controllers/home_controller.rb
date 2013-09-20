class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end

  #资源管理
  def asset
  end
  
  #网站通
  def site
  end

  def sms
  	if params[:processed].nil? #all
      @phone_items = current_user.phone_items.page(params[:page]).order("updated_at DESC")
    elsif params[:processed] == 'true' #processed
      @phone_items = current_user.phone_items.processed.page(params[:page]).order("updated_at DESC")
    else #not processed
      @phone_items = current_user.phone_items.no_processed.page(params[:page]).order("updated_at DESC")
    end
  end

  def email
    if params[:processed].nil? #all
      @mail_items = current_user.mail_items.page(params[:page]).order("updated_at DESC")
    elsif params[:processed] == 'true' #processed
      @mail_items = current_user.mail_items.processed.page(params[:page]).order("updated_at DESC")
    else #not processed
      @mail_items = current_user.mail_items.no_processed.page(params[:page]).order("updated_at DESC")
    end
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
