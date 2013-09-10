class SController < ApplicationController
  layout 's'
  before_action :set_site, only: [:show, :page, :post]

  def index
  end

  def show
    
  end

  def page
    @site_page = @site.site_pages.find_by(short_id: params[:page_id])
    @site_page ||= @site.site_pages.find_by(id: params[:page_id]) if params[:page_id] =~ /^\d+$/
    if @site_page.nil?
      render 'show'
    end
  end

  def post
    @site_post = @site.site_posts.find_by(id: params[:post_id])
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
