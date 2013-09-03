class AssetsController < ApplicationController
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

    #render :text => @asset.asset_file_name and return

    file_ext =  @asset.asset_file_name.sub(/(.*)\.([a-zA-Z]+)$/, '\2').to_s.downcase
    #validate
    #1. validate phone import
    if 'phone' == @asset.asset_type && !['xls', 'xlsx'].include?(file_ext) && 'application/vnd.ms-excel' != @asset.asset_content_type
      flash[:error] = "错误的文件格式，请导入Excel文件"
      return
    end
    respond_to do |format|
      if @asset.save
        case @asset.asset_type
        when 'phone' #import phone excel processing
          PhoneImportWorker.perform_async(@asset.asset.url, file_ext)
        end
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit(:asset, :asset_file_name, :asset_content_type, :asset_file_size, :asset_updated_at,
       :asset_type, :bucket)
    end
end
