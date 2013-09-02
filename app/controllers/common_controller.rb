class CommonController < ApplicationController
  def file_new
  	@upload_token = Qiniu::RS.generate_upload_token :scope => 'song-dev',
                                :callback_url       => '/home/sms',
                                :customer           => current_user.id.to_s
  end

  def file_upload
  	#render :text => params and return

  	
    return_hash = Qiniu::RS.upload_file :uptoken => params[:upload_token],
                      :file               => params[:filename],
                      :bucket             => 'song-dev',
                      :key                => 'keyss',
                      :note               => 'test'
    render :text => return_hash and return                  
  end
end
