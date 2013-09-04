class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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

end
