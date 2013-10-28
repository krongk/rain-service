#encoding: utf-8
# Define your site's name and default domain, which are used in various places,
class << Rails.application
  def domain
    if Rails.env == 'development'
       "121.199.46.174"
    else
      "65960.com"
    end
  end

  def name
    "65960"
   end
end

Rails.application.routes.default_url_options[:host] = Rails.application.domain
