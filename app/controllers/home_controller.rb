class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end

  def sms
  	@sms_tmp = SmsTmp.new
    @phone_item = PhoneItem.new
    @asset = Asset.new
    
    @phone_items_processed = current_user.phone_items.processed.page(params[:page])
    @phone_items_no_processed = current_user.phone_items.no_processed.page(params[:page])
  end

  def email
  end

  def qq
  end

  def share
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
  end
end
