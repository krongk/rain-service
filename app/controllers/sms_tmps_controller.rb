class SmsTmpsController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_sms_tmp, only: [:show, :edit, :update, :destroy]

  # GET /sms_tmps
  # GET /sms_tmps.json
  def index
    @sms_tmps = SmsTmp.where(:user_id => current_user.id).page(params[:page]|| 1).order("id DESC")
  end

  # GET /sms_tmps/1
  # GET /sms_tmps/1.json
  def show
  end

  # GET /sms_tmps/new
  def new
    @sms_tmp = SmsTmp.new
  end

  # GET /sms_tmps/1/edit
  def edit
  end

  # POST /sms_tmps
  # POST /sms_tmps.json
  def create
    @sms_tmp = SmsTmp.new(sms_tmp_params)

    #the content_size on view is just see for user, not the realy stored size.
    @sms_tmp.content_size = @sms_tmp.content.length

    respond_to do |format|
      if @sms_tmp.save
        format.html { redirect_to sms_tmps_url, notice: '短信模板添加成功.' }
        format.json { render action: 'show', status: :created, location: @sms_tmp }
      else
        format.html { render action: 'new' }
        format.json { render json: @sms_tmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms_tmps/1
  # PATCH/PUT /sms_tmps/1.json
  def update
    respond_to do |format|
      if @sms_tmp.update(sms_tmp_params)
        format.html { redirect_to sms_tmps_url, notice: '短信模板修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sms_tmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_tmps/1
  # DELETE /sms_tmps/1.json
  def destroy
    @sms_tmp.destroy
    respond_to do |format|
      format.html { redirect_to sms_tmps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sms_tmp
      @sms_tmp = SmsTmp.find(params[:id])
      @sms_tmp = @sms_tmp.user_id == current_user.id ? @sms_tmp : SmsTmp.where(:user_id => current_user.id).last
      can_access?(@sms_tmp)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sms_tmp_params
      params[:sms_tmp][:user_id] = current_user.id
      params.require(:sms_tmp).permit(:user_id, :title, :content, :content_size)
    end
end
