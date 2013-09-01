#encoding: utf-8
# Define your site's name and default domain, which are used in various places,
class << Rails.application
  def domain
    if Rails.env == 'development'
       "localhost:3000"
    else
      "www.yufuwu.cn"
    end
  end

  def name
    "雨服务"
   end
end

Rails.application.routes.default_url_options[:host] = Rails.application.domain
