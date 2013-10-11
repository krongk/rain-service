class SController < ApplicationController
  before_filter :load_site
  protect_from_forgery only: :post
  layout 's'
  #before_action :set_site, only: [:show, :page, :post, :blog]

  #Sub domain tutors：http://blog.xdite.net/posts/2013/07/21/implement-subdomain-custom-domain
  def load_site
    puts request.host
    puts request.port

    case request.host
    when "www.#{Rails.application.domain}", Rails.application.domain, 
      "www.#{Rails.application.domain}:#{request.port}", "#{Rails.application.domain}:#{request.port}", nil
      set_site
    else     
      if request.host.index(Rails.application.domain)
        @site = Site.find_by(short_id: request.host.split('.').first)
      else
        @site = Site.find_by(short_id: request.host)
      end

      if !@site
        redirect_to Rails.application.domain
      end

    end
  end

  def index
  end

  def show
    
  end

  def page
    @site_page = @site.site_pages.find_by(short_id: params[:page_id])
    @site_page ||= @site.site_pages.find_by(id: params[:page_id]) if params[:page_id] =~ /^\d+$/
    @site_page ||= @site.site_pages.first
    #Blog page
    if @site_page.short_id == 'blog'
      @site_posts = @site.site_posts.paginate(:page => params[:page], :per_page => 2).order("updated_at DESC")
    end
    @site_comment = @site.site_comments.build
    if @site_page.nil?
      render 'show'
    end
  end

  def post
    @site_page = @site.site_pages.find_by(short_id: 'post')
    @site_post = @site.site_posts.find_by(id: params[:post_id])
    @site_comment = @site.site_comments.build
    if @site_post.nil?
      render 'show'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find_by(short_id: params[:id])
      @site ||= Site.find_by(id: params[:id]) if params[:id] =~ /^\d+$/
      @site ||= Site.first
    end

end
