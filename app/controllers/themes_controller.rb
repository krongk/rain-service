class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :update, :destroy]

  def like_theme
    @theme_id = params[:theme_id]
    UserTheme.create(:user_id => current_user.id, :theme_id => @theme_id)
    respond_to do |format|
      if true
        format.html {}
        format.js   {}
        format.json {}
      else
        format.html {}
        format.json {}
      end
    end
  end
  # GET /themes
  # GET /themes.json
  def index
    @themes = Theme.all
  end

  # GET /themes/1
  # GET /themes/1.json
  def show
  end

  # GET /themes/new
  def new
    @theme = Theme.new
  end

  # GET /themes/1/edit
  def edit
  end

  # POST /themes
  # POST /themes.json
  def create
    @theme = Theme.new(theme_params)
    @theme.templete_image = "/themes/#{@theme.name}/preview.jpg" if @theme.templete_image.blank?
    @theme.templete_url = "/themes/#{@theme.name}/demo.html" if @theme.templete_url.blank?

    respond_to do |format|
      if @theme.save
        format.html { redirect_to themes_url, notice: '模板添加成功.' }
        format.json { render action: 'show', status: :created, location: @theme }
      else
        format.html { render action: 'new' }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
  def update
    respond_to do |format|
      if @theme.update(theme_params)
        @theme.templete_image = "/themes/#{@theme.name}/preview.jpg" if @theme.templete_image.blank?
        @theme.templete_url = "/themes/#{@theme.name}/demo.html" if @theme.templete_url.blank?
        @theme.save!

        format.html { redirect_to themes_url, notice: '模板更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
    @theme.destroy
    respond_to do |format|
      format.html { redirect_to themes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      params.require(:theme).permit(:name, :cate, :tags, :templete_image, :templete_url, :default_pages, :css_url, :js_url, :header, :body, :footer)
    end
end
