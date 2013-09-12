class PhoneItemsController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_phone_item, only: [:show, :edit, :update, :destroy]

  def phone_send
    if params[:sms_tmp_id].nil?
      flash[:error] = "没有选择短信模版"
      redirect_to "/home/sms" and return
    end
    if params[:phone_item_ids].nil?
      flash[:error] = "没有选择任何要发送的手机号"
      redirect_to "/home/sms" and return
    end

    if ENV['SMS_BAO_USER'].nil? || ENV['SMS_BAO_PASSWORD'].nil? || ENV['SMS_MAX_CHARACTER_COUNT'].nil?
      flash[:error] = "请配置短信发送接口的环境变量"
      redirect_to "/home/sms" and return
    end

    SmsSendWorker.perform_async(params[:sms_tmp_id], params[:phone_item_ids])

    respond_to do |format|
      format.html {redirect_to "/home/sms", notice: "短信已加入发送队列，请稍后查看发送日志: <a href='/phone_items'点击这里查看</a>"}
    end
  end

  def phone_import
    @asset = Asset.new
  end
  
  # GET /phone_items
  # GET /phone_items.json
  def index
    @phone_items = PhoneItem.where(:user_id => current_user.id).paginate(:page => params[:page]|| 1, :per_page => 50).order("updated_at DESC")
  end

  # GET /phone_items/1
  # GET /phone_items/1.json
  def show
    @sms_logs = @phone_item.sms_logs
  end

  # GET /phone_items/new
  def new
    @phone_item = PhoneItem.new
  end

  # GET /phone_items/1/edit
  def edit
  end

  # POST /phone_items
  # POST /phone_items.json
  def create
    @phone_item = PhoneItem.new(phone_item_params)
    @phone_item.user_id = current_user.id
    
    respond_to do |format|
      if @phone_item.save
        format.html { redirect_to phone_items_url, notice: '添加成功.' }
        format.json { render action: 'show', status: :created, location: @phone_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @phone_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone_items/1
  # PATCH/PUT /phone_items/1.json
  def update
    respond_to do |format|
      if @phone_item.update(phone_item_params)
        format.html { redirect_to phone_items_url, notice: '修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @phone_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_items/1
  # DELETE /phone_items/1.json
  def destroy
    @phone_item.destroy
    respond_to do |format|
      format.html { redirect_to phone_items_url, notice: '删除成功.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone_item
      @phone_item = PhoneItem.find(params[:id])
      @phone_item = @phone_item.user_id == current_user.id ? @phone_item : PhoneItem.where(:user_id => current_user.id).last
      can_access?(@phone_item)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_item_params
      params.require(:phone_item).permit(:mobile_phone, :source_name, :name, :city, :area, :description, :is_processed)
    end
end
