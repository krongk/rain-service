class FaqCatesController < ApplicationController
  before_action :set_faq_cate, only: [:show, :edit, :update, :destroy]

  # GET /faq_cates
  # GET /faq_cates.json
  def index
    @faq_cates = FaqCate.all
  end

  # GET /faq_cates/1
  # GET /faq_cates/1.json
  def show
  end

  # GET /faq_cates/new
  def new
    @faq_cate = FaqCate.new
  end

  # GET /faq_cates/1/edit
  def edit
  end

  # POST /faq_cates
  # POST /faq_cates.json
  def create
    @faq_cate = FaqCate.new(faq_cate_params)

    respond_to do |format|
      if @faq_cate.save
        format.html { redirect_to faq_cates_url, notice: 'Faq cate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @faq_cate }
      else
        format.html { render action: 'new' }
        format.json { render json: @faq_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faq_cates/1
  # PATCH/PUT /faq_cates/1.json
  def update
    respond_to do |format|
      if @faq_cate.update(faq_cate_params)
        format.html { redirect_to faq_cates_url, notice: 'Faq cate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @faq_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faq_cates/1
  # DELETE /faq_cates/1.json
  def destroy
    @faq_cate.destroy
    respond_to do |format|
      format.html { redirect_to faq_cates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faq_cate
      @faq_cate = FaqCate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def faq_cate_params
      params.require(:faq_cate).permit(:typo, :name, :is_auth)
    end
end
