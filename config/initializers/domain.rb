#encoding: utf-8
# Define your site's name and default domain, which are used in various places,
class << Rails.application
  def domain
    if Rails.env == 'development'
       "yufuwu.org"
    else
      "yufuwu.org"
    end
  end

  def name
    "65960"
   end
end

Rails.application.routes.default_url_options[:host] = Rails.application.domain
