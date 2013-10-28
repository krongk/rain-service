module CommonHelper
  #========================seo function
  #提交页面到搜索引擎入口
  SEO_GAGEWAY_URLS = {
    "Google谷歌"   => "https://www.google.com/webmasters/tools/submit-url?urlnt=[url]",
    "Baidu百度"    => "http://zhanzhang.baidu.com/sitesubmit/index?url=[url]",
    "Yahoo雅虎"    => "",
    "Bing微软"     => "http://www.bing.com/toolbox/submit-site-url?url=[url]",
    "Sogou搜狗"    => "http://www.sogou.com/feedback/urlfeedback.php?feedbackurl=[url]",
    "SoSo搜搜"     => "",
    "Dmoz "      => "",
    "TOM "       => "",
    "Coodir "    => "",
    "Alexa "     => "",
    "中搜"         => "",
    "iAsk 新浪爱问"  => "",
    "有道搜索"       => "http://tellbot.youdao.com/report?url=[url]",
    "Masterseek" => "",
  }
  def get_seo_gateway_urls(url)
    links = []
    SEO_GAGEWAY_URLS.each_pair do |key, gateway_url|
      next if gateway_url.blank?
      links << link_to(key, gateway_url.sub(/\[url\]/, url), target: "_blank")
    end
    links
  end
  #====================================
end
