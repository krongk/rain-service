class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_current_user, :check_initializer

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  layout :layout

  private

  def layout
    ## only turn it off for login pages:
    # is_a?(Devise::SessionsController) ? false : "application"
    ## or turn layout off for every devise controller:
    devise_controller? ? "users" : "application"
  end

  #put it on controller method: set_object
  #rule: if use owned object, only owner can access.
  def can_access?(object)
    unless object.respond_to?(:user_id) ? (object.user_id == current_user.id) : true
      redirect_to root_path, :alert => "没有访问权限"
    end
  end

  #Can access current_user on Model
  def set_current_user
    User.current_user = current_user
  end

  #If user login, need to initialize user_accounts OR others
  #Trigger: if user login and has created almost one site.
  def check_initializer
    return unless current_user
    #get required account
    required_user_accounts = ApplicationHelper::USER_ACCOUTNS.dup.reject{|ua| 
      [
        ['MailGun邮箱账户', 'mailgun_name'],
        ['MailGun邮箱密码', 'mailgun_password'],
        ['Google邮箱账户', 'gmail_name'],
        ['Google邮箱密码', 'gmail_password']
      ].include?(ua)}
    
    if params[:controller] != 'user_accounts'  &&
      current_user.sites.any? &&
      current_user.user_accounts.size < required_user_accounts.size
      
      redirect_to user_accounts_url, :alert => "请在做其他操作前，在这里将账户信息完善了。账户信息绑定到每个应用的功能。" and return
    end
  end

end
