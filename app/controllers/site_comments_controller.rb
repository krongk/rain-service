class SiteCommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]
  before_action :set_site
  before_action :set_site_comment, except: [:index, :new, :create]

  # GET /site_comments
  # GET /site_comments.json
  def index
    @site_comments = SiteComment.all
  end

  # GET /site_comments/1
  # GET /site_comments/1.json
  def show
  end

  # GET /site_comments/new
  def new
    @site_comment = @site.site_comments.build
  end

  # GET /site_comments/1/edit
  def edit
  end

  # POST /site_comments
  # POST /site_comments.json
  def create
    redirect_url = site_comment_params[:redirect_url]
    @site_comment = SiteComment.new(site_comment_params)

    respond_to do |format|
      if @site_comment.save
        format.html { redirect_to redirect_url, notice: '留言成功.' }
        format.json { render action: 'show', status: :created, location: @site_comment }
      else
        format.html { redirect_to redirect_url, notice: '留言失败，请检查是否输入正确.' }
        format.json { render json: @site_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_comments/1
  # PATCH/PUT /site_comments/1.json
  def update
    respond_to do |format|
      if @site_comment.update(site_comment_params)
        format.html { redirect_to @site_comment, notice: 'Site comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_comments/1
  # DELETE /site_comments/1.json
  def destroy
    @site_comment.destroy
    respond_to do |format|
      format.html { redirect_to site_comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find_by(id: params[:site_id])
    end
    def set_site_comment
      @site_comment = SiteComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_comment_params
      params.require(:site_comment).permit(:site_id, :redirect_url, :name, :mobile_phone, :email, :content, :is_processed)
    end
end
