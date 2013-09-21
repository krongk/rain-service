class MailItemsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_mail_item, only: [:show, :edit, :update, :destroy]

  #POST
  def mail_send
    cate = params[:cate] || 'gmail'
    mail_tmp = MailTmp.find(params[:mail_tmp_id])
    if mail_tmp.nil? || params[:mail_item_ids].nil? || params[:mail_item_ids].empty?
      flash[:error] = "没有选择任何邮件模版或要发送的邮箱"
      redirect_to "/home/email"
      return
    end

    #邮件按照10个分组，每次群发10个。
    per_emails = []
    tmp_arr = []
    params[:mail_item_ids].to_a.each do |id|
      tmp_arr << id
      if tmp_arr.size == 10
        per_emails << tmp_arr
        tmp_arr = []
      end
    end
    per_emails << tmp_arr unless tmp_arr.empty?

    step_minutes = 0 #发送分钟间隔
    per_emails.each do |mail_item_ids|
      mail_items = MailItem.where(:id => mail_item_ids)
      #Workder一次发送10个
      # MyWorker.perform_in(3.hours, 'mike', 1)
      # MyWorker.perform_at(3.hours.from_now, 'mike', 1)
      # MailSendWorker.perform_async(current_user.id, cate, mail_tmp.id, mail_items.map(&:email).join(";"))
      step_minutes += 5
      t = step_minutes + rand(3)
      MailSendWorker.perform_at(t.minutes.from_now, current_user.id, cate, mail_tmp.id, mail_items.map(&:email).join(";"))

      #状态处理
      mail_items.each do |item|
        status = 'y'
        item.is_processed = item.is_processed == 'n' ? "#{mail_tmp.id},#{status}" : "#{mail_tmp.id},#{status}|" + item.is_processed
        item.save!
        
        billing_count = 1
        MailLog.create!(
            :user_id => item.user_id, 
            :mail_item_id => item.id, 
            :mail_tmp_id => mail_tmp.id, 
            :status => status,
            :billing_count => billing_count)

        #increment billing count
        Keystore.increment_value_for("user:#{item.user_id}:mail_billing_count", billing_count)

        #increment send count(per phone per send)
        Keystore.increment_value_for("user:#{item.user_id}:mail_send_count", 1)
      end
    end

    respond_to do |format|
      format.html {redirect_to "/home/email", notice: '邮件已经加入发送队列，请稍后查看<a href="/mail_items">发送日志</a>！'}
    end
  end

  def mail_import
    @asset = Asset.new
  end

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
      can_access?(@mail_item)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_item_params
      params.require(:mail_item).permit(:email, :source_name, :name, :city, :area, :description, :is_processed)
    end
end
