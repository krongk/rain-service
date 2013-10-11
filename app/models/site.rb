#encoding: utf-8
class Site < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme
  has_many :site_pages, :dependent => :destroy
  has_many :site_posts, :dependent => :destroy
  has_many :site_comments, :dependent => :destroy

  liquid_methods :id, :site_posts, :title, :contact_name, :mobile_phone, :tel_phone, :qq, :email, :website, :address, :company_name

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
    self.head << "\n"
    self.head << theme.js_url.to_s.split(/\n+/).map{|j| %(<script src="#{j.strip}"></script>)}.join("\n")

    self.header = get_theme_content(theme.header)
    self.body   = get_theme_content(theme.body)
    self.footer = get_theme_content(theme.footer)
    self.save!
  end

  #关于|活动通知|决赛方案|活动系列|媒体报道|主办单位|邀请函|联系我们
  def create_default_site_pages
    theme = Theme.find_by_id(self.theme_id)
    return if theme.nil?
    theme.default_pages.split('|').map{|p| p.strip}.each do |p|
      next if p.nil?
      en_title = Pinyin.t(p, splitter: '-')
      sp = SitePage.find_or_initialize_by(user_id: self.user_id, site_id: self.id, short_id: en_title)
      sp.title = p
      sp.content = get_site_page_content(theme.name, p)
      sp.save!
    end 
  end
  #将模版内容中的路径变量替换
  # {url_for(/)} => http://xdjb.65960.com:3000/
  # {url_for(/p/about)} => http://xdjb.65960.com:3000/p/about
  def get_theme_content(content)
    content
    #domain = Rails.application.domain.dup.sub(/^www./, '')
    #return content.to_s.gsub(/\{url_for\((.*)\)\}/, ["http://#{self.short_id}.#{domain}", '\1'].join('/') )
    #return content.to_s.gsub(/\{url_for\((.*)\)\}/, '\1' )
  end

  #将模板下面的文件内容拷到对应的页面中， 
  #即 if(page.name == 'about'){/publc/themes/clean_canvas/关于.html => page.content}
  #即 if(page.name == 'about'){/publc/themes/clean_canvas/guan-yu.html => page.content}
  def get_site_page_content(theme_name, page_name)
    if File.exist?( f = File.join(Rails.root, 'public', 'themes', theme_name, page_name + '.html')) ||
       File.exist?( f = File.join(Rails.root, 'public', 'themes', theme_name, Pinyin.t(page_name, splitter: '-') + '.html'))
      return File.read(f)
    end
    return ''
  end

end
