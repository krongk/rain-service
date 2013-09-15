class SitePostsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_site_post, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # GET /site_posts
  # GET /site_posts.json
  def index
    if @site.nil?
      redirect_to sites_url
      return
    end
    @site_posts = @site.site_posts.page(params[:page]).order("updated_at DESC")
  end

  # GET /site_posts/1
  # GET /site_posts/1.json
  def show
  end

  # GET /site_posts/new
  def new
    @site_post = SitePost.new
  end

  # GET /site_posts/1/edit
  def edit
  end

  # POST /site_posts
  # POST /site_posts.json
  def create
    @site_post = SitePost.new(site_post_params)
    @site_post.user_id = current_user.id

    respond_to do |format|
      if @site_post.save
        format.html { redirect_to site_site_posts_url(@site_post.site), notice: '添加成功.' }
        format.json { render action: 'show', status: :created, location: @site_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @site_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_posts/1
  # PATCH/PUT /site_posts/1.json
  def update
    respond_to do |format|
      if @site_post.update(site_post_params)
        format.html { redirect_to site_site_posts_url(@site_post.site), notice: '添加成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_posts/1
  # DELETE /site_posts/1.json
  def destroy
    @site_post.destroy
    respond_to do |format|
      format.html { redirect_to site_site_posts_url(@site_post.site) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_post
      @site = Site.find_by(id: params[:site_id])
      @site_post = SitePost.find_by(id: params[:id])
      can_access?(@site_post)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_post_params
      params.require(:site_post).permit(:user_id, :site_id, :title, :content, :key_words, :cate_id)
    end
end
