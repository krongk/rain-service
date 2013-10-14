#encoding: utf-8
# Define your site's name and default domain, which are used in various places,
class << Rails.application
  def domain
    if Rails.env == 'development'
       "yufuwu.org"
    else
      "65960.com"
    end
  end

  def name
    "雨服务智能营销系统"
   end
end

Rails.application.routes.default_url_options[:host] = Rails.application.domain
