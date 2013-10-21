class SController < ApplicationController
  before_filter :load_site
  protect_from_forgery only: :post
  layout 's'

  #site index page
  def show
  end

  #required variable: @site, @site_page
  #option variable: @site_posts, @site_post, @site_comment
  def page
    #render text: params and return
    # http://fhhl.yufuwu.org:3000/p/post/18
    # => {"controller"=>"s", "action"=>"page", "page_id"=>"post", "post_id"=>"18"}
    @site_page = @site.site_pages.find_by(short_id: params[:page_id])
    @site_page ||= @site.site_pages.find_by(id: params[:page_id]) if params[:page_id] =~ /^\d+$/
    #@site_page ||= @site.site_pages.first
    if @site_page.nil?
      render 'show' and return
    end
    #Blog
    if @site_page.short_id == 'blog'
      @site_posts = @site.site_posts.order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 3)
    end
    #Blog detail(post): /p/post/2
    #if @site_page.short_id == 'post'
    @site_post = @site.site_posts.find_by(id: params[:post_id])   

  end

  private
  #Sub domain tutors：http://blog.xdite.net/posts/2013/07/21/implement-subdomain-custom-domain
  #判断
  # => 如果是一级域名，则转到官网
  # => 如果是二级域名，则跳转到各网站
  def load_site
    case request.host
    when "www.#{Rails.application.domain}", Rails.application.domain, 
      "www.#{Rails.application.domain}:#{request.port}", "#{Rails.application.domain}:#{request.port}", nil
      set_site
    else
      #The sequences will be : subdomain => custom domain => Not Found
      if request.host.index(Rails.application.domain)
        @site = Site.find_by(short_id: request.host.split('.').first)
      else
        @site = Site.find_by(short_id: request.host)
      end

      if !@site
        redirect_to redirect_to "http://www." + Rails.application.domain
      end
    end
    #comment anywhere
    @site_comment = @site.site_comments.build
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_site
    @site = Site.find_by(short_id: params[:id])
    @site ||= Site.find_by(id: params[:id]) if params[:id] =~ /^\d+$/
    @site ||= Site.first
  end
end
