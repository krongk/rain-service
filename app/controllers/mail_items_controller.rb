class MailItemsController < ApplicationController
  before_action :set_mail_item, only: [:show, :edit, :update, :destroy]

  # GET /mail_items
  # GET /mail_items.json
  def index
    @mail_items = current_user.mail_items.paginate(:page => params[:page] || 1, :per_page => 100).order("updated_at DESC")
  end

  # GET /mail_items/1
  # GET /mail_items/1.json
  def show
  end

  # GET /mail_items/new
  def new
    @mail_item = MailItem.new
  end

  # GET /mail_items/1/edit
  def edit
  end

  # POST /mail_items
  # POST /mail_items.json
  def create
    @mail_item = MailItem.new(mail_item_params)
    @mail_item.user_id = current_user.id

    respond_to do |format|
      if @mail_item.save
        format.html { redirect_to @mail_item, notice: '添加成功.' }
        format.json { render action: 'show', status: :created, location: @mail_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @mail_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_items/1
  # PATCH/PUT /mail_items/1.json
  def update
    respond_to do |format|
      if @mail_item.update(mail_item_params)
        format.html { redirect_to @mail_item, notice: '更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mail_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_items/1
  # DELETE /mail_items/1.json
  def destroy
    @mail_item.destroy
    respond_to do |format|
      format.html { redirect_to mail_items_url, notice: '删除成功.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_item
      @mail_item = MailItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_item_params
      params.require(:mail_item).permit(:email, :source_name, :name, :city, :area, :description, :is_processed)
    end
end
