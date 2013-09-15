class MailTmpsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_mail_tmp, only: [:show, :edit, :update, :destroy]

  # GET /mail_tmps
  # GET /mail_tmps.json
  def index
    @mail_tmps = current_user.mail_tmps.page(params[:page]).order("updated_at DESC")
  end

  # GET /mail_tmps/1
  # GET /mail_tmps/1.json
  def show
  end

  # GET /mail_tmps/new
  def new
    @mail_tmp = MailTmp.new
  end

  # GET /mail_tmps/1/edit
  def edit
  end

  # POST /mail_tmps
  # POST /mail_tmps.json
  def create
    @mail_tmp = MailTmp.new(mail_tmp_params)
    @mail_tmp.user_id = current_user.id

    respond_to do |format|
      if @mail_tmp.save
        format.html { redirect_to mail_tmp_path(@mail_tmp), notice: '邮件模板添加成功.' }
        format.json { render action: 'show', status: :created, location: @mail_tmp }
      else
        format.html { render action: 'new' }
        format.json { render json: @mail_tmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_tmps/1
  # PATCH/PUT /mail_tmps/1.json
  def update
    respond_to do |format|
      if @mail_tmp.update(mail_tmp_params)
        format.html { redirect_to mail_tmps_url, notice: '邮件模板修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mail_tmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_tmps/1
  # DELETE /mail_tmps/1.json
  def destroy
    @mail_tmp.destroy
    respond_to do |format|
      format.html { redirect_to mail_tmps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_tmp
      @mail_tmp = MailTmp.find(params[:id])
      can_access?(@mail_tmp)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_tmp_params
      params.require(:mail_tmp).permit(:title, :content)
    end
end
