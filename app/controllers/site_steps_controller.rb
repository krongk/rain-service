class SiteStepsController < ApplicationController
  include Wicked::Wizard

  steps :title, :content, :publish
  
  def show
    @site = Site.find(session[:site_id])
    render_wizard
  end
  
  def update
  
    @site = Site.find(session[:site_id])
    @site.update(site_params)
    render_wizard @site
  end

  def redirect_to_finish_wizard(site)
    session[:site_id] = nil
    redirect_to sites_url, notice: "网站创建成功."
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:user_id, :short_id, :title, :domain, :theme_id, :head, :header, :body, :footer, :is_published, :contact_name, :mobile_phone, :tel_phone, :qq, :email, :website, :address, :company_name)
    end
end
