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
  # 在模板中， [首页, index, shouye, shou-ye] 几个名字是等价的，等价的存储到'首页' 的 site_page中。
  # 页面的扩展名是[htm, html]都可以
  def get_site_page_content(theme_name, page_name)
    name_hash = {
      '首页' => 'index',
      '关于' => 'about',
      '关于我们' => 'about',
      '联系' => 'contact',
      '联系我们' => 'contact',
      '服务' => 'service',
      '服务项目' => 'service',
      '博客' => 'blog',
      '在线帮助' => 'faq',
      '帮助问答' => 'help',
      '帮助说明' => 'help',
      '投资组合' => 'portfolio',
      '产品介绍' => 'product',
      '项目介绍' => 'project',
      '活动' => 'event',
      '新闻' => 'news',
      '新闻报道' => 'news',
      '案例' => 'case',
      '案例展示' => 'case',
    }
    [
      name_hash[page_name], #index
      Pinyin.t(page_name, splitter: ''), #shouye
      Pinyin.t(page_name, splitter: '-'), #shou-ye
      page_name, #首页
    ].each do |p_name|
      next if p_name.nil?
      if File.exist?( f = File.join(Rails.root, 'public', 'themes', theme_name, p_name + '.html')) ||
         File.exist?( f = File.join(Rails.root, 'public', 'themes', theme_name, p_name + '.htm'))
        return File.read(f)
      end
    end
    return ''
  end

end
