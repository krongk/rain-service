module ApplicationHelper
  include CommonHelper
  
  THEME_CATES = [['博客型超级换肤型', 'bootswatch'], ['企业超级定制型', 'bootsbiz']]
  COLOR_NAMES = ["contrast", "orange", "blue", "purple", "green", "red", "muted", "fb", "dark", "pink", "grass-green", "sea-blue", "banana", "dark-orange", "brown"]
  THEME_NAMES = ["red","orange", "blue", "purple", "green", "fb", "muted", "dark", "pink", "grass-green", "sea-blue", "banana", "dark-orange", "brown"]

  USER_ACCOUTNS =[
    #required
    ['网站域名', 'domain'],

    ['QQ邮箱账户', 'qmail_name'],
    ['QQ邮箱密码', 'qmail_password'],

    ['七牛云存储账户', 'qiniu_name'],
    ['七牛云存储密码', 'qiniu_password'],
    ['七牛云存储ACCESS_KEY', 'qiniu_access_key'],
    ['七牛云存储SECRET_KEY', 'qiniu_secret_key'],
    ['七牛云存储空间名', 'qiniu_bucket'],
    ['七牛云存储访问地址', 'qiniu_host'],

    #not required
    ['MailGun邮箱账户', 'mailgun_name'],
    ['MailGun邮箱密码', 'mailgun_password'],
    ['Google邮箱账户', 'gmail_name'],
    ['Google邮箱密码', 'gmail_password']
  ]

  SMS_SEND_STATUS = {
    0 => ['成功', 'success'], 
    30 => ['密码错误', 'error'],
    40 => ['账户错误', 'error'],
    41 => ['欠费', 'warning'],
    42 => ['账户过期', 'error'],
    43 => ['IP被封', 'warning'],
    50 => ['敏感内容', 'warning'],
    51 => ['号码错误', 'error'],
    100 => ['未知错误', 'info']
  }
  MAIL_SEND_STATUS = {
    0 => ['成功', 'success'], 
    1 => ['失败', 'error']
  }

  BADGE_FLAG = {'success' => '成功', 'error' => '错误', 'warning' => '警告', 'important' => '严重', 'info' => '提示', 'inverse' => '失败'}
  def rand_flag
    BADGE_FLAG.keys[rand(5)]
  end

  #[3,0][1,30] => [sms_tmp_id, send_status]
  def show_send_status(is_processed)
    if is_processed == 'n'
      return "<span class='badge badge-info' title='未发送'>未发送</span>".html_safe
    end

    arr = []
    is_processed.split("|").reverse.each do |s|
      sms_tmp_id, send_status = s.split(',')
      flag = case send_status.to_i
      when 0 then 'success'
      when 30..42 then 'warning'
      when 43..51 then 'important'
      else 'inverse'
      end
      arr << "<span class='badge badge-#{flag}' title='#{BADGE_FLAG[flag]}'>#{sms_tmp_id}</span>"
    end
    arr.join.html_safe
  end
  
  def display_base_errors resource
    return '' if resource.nil?
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def title(page_title)
    content_for(:title){ page_title}
  end
  def meta_keywords(meta_keywords)
    content_for(:meta_keywords){ meta_keywords}
  end
  def meta_description(meta_description)
    content_for(:meta_description){ meta_description}
  end

  def liquidize(content, arguments)
    #Liquid::Template.parse(content).render(arguments, :filters => [LiquidFilters])
    Liquid::Template.parse(content).render(arguments)
  end

  #on sites/index to get site short url
  #e.g. 
  # => short_id.domain.com
  # => short_id.domain.com/p/page_id(or page.short_id)
  # => => short_id.domain.com/p/page_id/post_id
  #how to call:
  # => get_short_url(@site, @site_page, nil)
  # => get_short_url(@site, @site.site_pages.find_by(short_id: 'post'), @site_post)
  def get_short_url(site, page = nil, post = nil)
    return '/' if site.nil?
    #url = "/s/#{site.short_id}"
    url = "#{request.protocol}#{site.short_id}.#{request.host_with_port.sub(/^www\./i, '')}" #http://short_id.65960.com:3000
    url << "/p/#{page.short_id}" unless page.nil?
    url << "/#{post.id}" unless post.nil?
    return url
  end

  # 65960.com => http://www.65960.com
  # site.65960.com => http://site.65960.com
  def get_url(url, subdomain = false)
    path = url.sub(/^http(s)?:\/\//, '').sub(/^www./, '')
    return subdomain ? ['http://', path].join.strip : ['http://', 'www.', path].join.strip
  end

  #On admin page title, e.g. /home/sms
  # <%= page_header('短信通', {'发送日志' => '/phone_items',}) %>
  def page_header(title, opts = {})
    arr = []
    arr << %{
      <div class="row-fluid">
        <div class="span12">
          <div class="page-header">

            <!-- page title -->
            <h1 class="pull-left">
              <i class="icon-star"></i>
              <span>#{title}</span>
            </h1>

            <!-- breadcrumbs -->
            <div class="pull-right">
              <div class="btn-group">
                <a href="/home/index" clas="btn btn-white"><i class="icon-bar-chart"></i>返回</a>}

                opts.each_pair do |k, v|
                  if k =~ /返回|控制面板/
                    arr << link_to(k, v, :class=> 'btn btn-white') 
                  else
                    arr << link_to(k, v, :class=> 'btn btn-primary')
                  end
                end

                arr << %{</div>
            </div>

          </div>
        </div>
      </div>
    }
    arr.join.html_safe
  end

  # <%= box_title('日志查看') %>
  def box_title(title, color = 'blue')
    %{
      <div class="box-header #{color}-background">
          <div class="title">#{title}</div>
          <div class="actions">
              <a href="#" class="btn box-collapse btn-mini btn-link"><i></i>
              </a>
          </div>
      </div>
    }.html_safe
  end
  
  #flash动画显示
  # eg: play_flash("flash/top_banner.swf")
  # or: play_flash asset_path("flash/top_banner.swf"), :width => '985', :height => '249'
  def play_flash(src, options = {:width=>'600', :height=>'400'})
    str = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' width='"+ options[:width] +"' height='"+ options[:height] +"' id='FlashID' accesskey='1' tabindex='1' title='daiii'>
        <param name='movie' value='" + src + "' />
        <param name='quality' value='high' />
        <param name='wmode' value='transparent' />
        <param name='swfversion' value='9.0.45.0' />
        <!--[if !IE]>-->
        <object type='application/x-shockwave-flash' data='" + src + "' width='"+  options[:width] +"' height='"+  options[:height] +"'>
          <!--<![endif]-->
          <param name='movie' value='" + src + "' />
          <param name='quality' value='high' />
          <param name='wmode' value='transparent' />
          <param name='swfversion' value='9.0.45.0' />
          <div>
            <h4>Plsease update Adobe Flash Player。</h4>
          </div>
          <!--[if !IE]>-->
        </object>
        <!--<![endif]-->
      </object>"
    return str.html_safe
  end

end
