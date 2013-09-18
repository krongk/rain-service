class UserAccountsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user_account, only: [:show, :edit, :update, :destroy]

  # GET /user_accounts
  # GET /user_accounts.json
  def index
    @user_accounts = current_user.user_accounts.all
  end

  # GET /user_accounts/1
  # GET /user_accounts/1.json
  def show
  end

  # GET /user_accounts/new
  def new
    @user_account = UserAccount.new
  end

  # GET /user_accounts/1/edit
  def edit
  end

  # POST /user_accounts
  # POST /user_accounts.json
  def create
    @user_account = UserAccount.new(user_account_params)
    @user_account.user_id = current_user.id

    respond_to do |format|
      if @user_account.save
        format.html { redirect_to user_accounts_url, notice: '创建成功.' }
        format.json { render action: 'show', status: :created, location: @user_account }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_accounts/1
  # PATCH/PUT /user_accounts/1.json
  def update
    respond_to do |format|
      if @user_account.update(user_account_params)
        format.html { redirect_to user_accounts_url, notice: '修改成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_accounts/1
  # DELETE /user_accounts/1.json
  def destroy
    @user_account.destroy
    respond_to do |format|
      format.html { redirect_to user_accounts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_account
      @user_account = UserAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_account_params
      params.require(:user_account).permit(:user_id, :name, :value)
    end
end
