class Theme < ActiveRecord::Base
  has_many :user_themes
  before_save :generate_urls

  def generate_urls
    self.css_url= get_urls(self.css_url)
    self.js_url = get_urls(self.js_url)
    self.header = get_urls(self.header)
    self.body   = get_urls(self.body)
    self.footer = get_urls(self.footer)
  end

  # <link href="css/bootstrap.css" rel="stylesheet">
  # => <link rel="stylesheet" type="text/css" href="/themes/cryption/css/bootstrap.css">
  def get_urls(str)
    #css url
    str = str.force_encoding("utf-8").gsub(/(src|href)="(css|style|js|javascript|img|image|images)\//, '\1="/themes/<the_theme_name>/\2/')
    str = str.gsub(/<the_theme_name>/, self.name)
    str
  end

end
