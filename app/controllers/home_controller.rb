class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end

  def sms
  	@sms_tmp = SmsTmp.new
    @phone_item = PhoneItem.new
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
