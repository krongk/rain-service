#encoding: utf-8
class AssetsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  # GET /assets
  # GET /assets.json
  def index
    @assets = Asset.all
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
  end

  # GET /assets/new
  def new
    @asset = Asset.new
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = Asset.new(asset_params)
    @asset.user_id = current_user.id

    #render :text => params and return
    #validates
    if @asset.asset_file_name.nil? || @asset.asset_type.nil? || @asset.bucket.nil?
      redirect_to(params[:redirect_url] || '/', error: "请指定要上传的内容") and return 
    end

    file_ext =  @asset.asset_file_name.sub(/(.*)\.([a-zA-Z]+)$/, '\2').to_s.downcase

    #1. validate phone import and mail
    if ['phone', 'mail'].include?(@asset.asset_type) && !['xls', 'xlsx'].include?(file_ext)
      flash[:error] = "错误的文件格式，请导入Excel文件"
      redirect_to params[:redirect_url] || '/' and return 
    end

    respond_to do |format|
      if @asset.save
        redicect_url = asset_path(@asset)
        notice = '资源添加成功.'

        case @asset.asset_type
        when 'phone' #import phone excel processing
          PhoneImportWorker.perform_async(@asset.id, file_ext)
          redicect_url = params[:redirect_url]
          notice = "文档已经导入后台执行，这需要一会儿时间，请耐心等待一下再刷新该页面。"
        when 'mail' #import mail excel processing
          MailImportWorker.perform_async(@asset.id, file_ext)
          redicect_url = params[:redirect_url]
          notice = "文档已经导入后台执行，这需要一会儿时间，请耐心等待一下再刷新该页面。"
        end

        format.html { redirect_to redicect_url, notice: notice }
        format.json { render action: 'show', status: :created, location: @asset }
      else
        format.html { render action: 'new' }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = Asset.find(params[:id])
      can_access?(@asset)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit(:asset, :asset_file_name, :asset_content_type, :asset_file_size, :asset_updated_at,
       :asset_type, :bucket)
    end
end
