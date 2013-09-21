class SitesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site_pages = @site.site_pages.order("updated_at DESC").limit(20)
    @site_posts = @site.site_posts.order("updated_at DESC").limit(20)
    @site_comments = @site.site_comments.order("updated_at DESC").limit(20)
  end

  # GET /sites/new
  def new
    @site = Site.new
    @themes = current_user.themes
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)
    @site.user_id = current_user.id

    respond_to do |format|
      if @site.save
        session[:site_id] = @site.id
        
        format.html { redirect_to site_steps_path, notice: '提交成功.' }
        format.json { render action: 'show', status: :created, location: @site }
      else
        format.html { render action: 'new' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        session[:site_id] = @site.id
        
        format.html { redirect_to site_steps_path, notice: '提交成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:user_id, :short_id, :title, :domain, :theme_id, :head, :header, :body, :footer, :is_published)
    end
end
