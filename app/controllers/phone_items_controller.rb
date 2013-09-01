class PhoneItemsController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_phone_item, only: [:show, :edit, :update, :destroy]

  # GET /phone_items
  # GET /phone_items.json
  def index
    @phone_items = PhoneItem.where(:user_id => current_user.id).page(params[:page]).order("updated_at DESC")
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
      format.html { redirect_to phone_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone_item
      @phone_item = PhoneItem.find(params[:id])
      @phone_item = @phone_item.user_id == current_user.id ? @phone_item : PhoneItem.where(:user_id => current_user.id).last
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_item_params
      params[:phone_item][:user_id] = current_user.id
      params.require(:phone_item).permit(:user_id, :mobile_phone, :source_name, :name, :city, :area, :description, :is_processed)
    end
end