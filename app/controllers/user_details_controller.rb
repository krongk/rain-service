class UserDetailsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user_detail, only: [:show, :edit, :update, :destroy]

  # GET /user_details
  # GET /user_details.json
  def index
    #@user_details = UserDetail.all
  end

  # GET /user_details/1
  # GET /user_details/1.json
  def show
  end

  # GET /user_details/new
  def new
    @user_detail = UserDetail.new
  end

  # GET /user_details/1/edit
  def edit
  end

  # POST /user_details
  # POST /user_details.json
  def create
    @user_detail = UserDetail.new(user_detail_params)

    respond_to do |format|
      if @user_detail.save
        format.html { redirect_to edit_user_detail_path(@user_detail), notice: '会员信息添加成功.' }
        format.json { render action: 'show', status: :created, location: @user_detail }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_details/1
  # PATCH/PUT /user_details/1.json
  def update
    respond_to do |format|
      if @user_detail.update(user_detail_params)
        format.html { redirect_to edit_user_detail_path(@user_detail), notice: '会员信息修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_details/1
  # DELETE /user_details/1.json
  def destroy
    @user_detail.destroy
    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_detail
      @user_detail = current_user.user_detail
      can_access?(@user_detail)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_detail_params
      params.require(:user_detail).permit(:contact_name, :id_card, :mobile_phone, :tel_phone, :qq, :email, :website, :region, :city, :district, :address, :latitude, :longitude, :company_name, :company_nickname, :corporator, :company_reg_no, :company_keywords, :company_description)
    end
end
