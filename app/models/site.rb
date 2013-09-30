#encoding: utf-8
class Site < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme
  has_many :site_pages, :dependent => :destroy
  has_many :site_posts, :dependent => :destroy
  has_many :site_comments, :dependent => :destroy

  liquid_methods :site_posts, :title, :contact_name, :mobile_phone, :tel_phone, :qq, :email, :website, :address, :company_name

  validates_presence_of :theme_id
  before_validation :assign_short_id,
    :on => :create
  validates_uniqueness_of :short_id, :case_sensitive => false
  
  after_create  :assign_theme_content, :create_default_site_pages, :increment_total_count
  after_destroy :decrement_total_count

  private

  def increment_total_count
    Keystore.increment_value_for("user:#{self.user_id}:sites_count")
  end
  def decrement_total_count
    Keystore.decrement_value_for("user:#{self.user_id}:sites_count")
  end

  def assign_short_id
    self.short_id = ShortId.new(self.class).generate
  end

  def assign_theme_content
    theme = Theme.find_by_id(self.theme_id)
    return if theme.nil?
    self.head = theme.css_url.to_s.split(/\n+/).map{|c| %(<link rel="stylesheet" type="text/css" href="#{c.strip}">)}.join("\n")
    self.head << theme.js_url.to_s.split(/\n+/).map{|j| %(<script src="#{j.strip}"></script>)}.join("\n")

    self.header = get_theme_content(theme.header)
    self.body   = get_theme_content(theme.body)
    self.footer = get_theme_content(theme.footer)
    self.save!
  end

  #首页, index|关于, about|产品特色, features|产品列表, portfolio
  def create_default_site_pages
    theme = Theme.find_by_id(self.theme_id)
    return if theme.nil?
    theme.default_pages.split('|').each do |p|
      title, name = p.split(/[,; ]+/)
      sp = SitePage.find_or_initialize_by(user_id: self.user_id, site_id: self.id, short_id: name)
      sp.title = title
      sp.content = get_site_page_content(theme.name, name)
      sp.save!
    end 
  end
  #将模版内容中的路径变量替换
  # {url_for(/)} => http://xdjb.65960.com:3000/
  # {url_for(/p/about)} => http://xdjb.65960.com:3000/p/about
  def get_theme_content(content)
    domain = Rails.application.domain.dup.sub(/^www./, '')
    #return content.to_s.gsub(/\{url_for\((.*)\)\}/, ["http://#{self.short_id}.#{domain}", '\1'].join('/') )
    return content.to_s.gsub(/\{url_for\((.*)\)\}/, '\1' )
  end

  #将模板下面的文件内容拷到对应的页面中， 
  #即 if(page.name == 'about'){/publc/themes/clean_canvas/about.html => page.content}
  def get_site_page_content(theme_name, page_name)
    if File.exist?( f = File.join(Rails.root, 'public', 'themes', theme_name, page_name + '.html'))
      return File.read(f)
    end
    return ''
  end

end
