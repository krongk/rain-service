class SitePagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_site_page, only: [:new, :show, :edit, :update, :destroy]

  # GET /site_pages
  # GET /site_pages.json
  def index
    @sites = current_user.sites
  end

  # GET /site_pages/1
  # GET /site_pages/1.json
  # http://localhost:3000/sites/19/site_pages/80
  # {"action"=>"show", "controller"=>"site_pages", "site_id"=>"19", "id"=>"80"}
  def show
  end

  # GET /site_pages/new
  def new
    @site_page = SitePage.new
  end

  # GET /site_pages/1/edit
  def edit
  end

  # POST /site_pages
  # POST /site_pages.json
  def create
    @site_page = SitePage.new(site_page_params)

    respond_to do |format|
      if @site_page.save
        format.html { redirect_to site_pages_url, notice: '添加成功.' }
        format.json { render action: 'show', status: :created, location: @site_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @site_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_pages/1
  # PATCH/PUT /site_pages/1.json
  def update
    respond_to do |format|
      if @site_page.update(site_page_params)
        format.html { redirect_to site_pages_url, notice: '添加成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_pages/1
  # DELETE /site_pages/1.json
  def destroy
    @site_page.destroy
    respond_to do |format|
      format.html { redirect_to site_pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_page
      @site = Site.find_by(id: params[:site_id])
      @site_page = SitePage.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_page_params
      params.require(:site_page).permit(:user_id, :short_id, :site_id, :title, :content)
    end
end
