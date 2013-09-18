RainService::Application.routes.draw do
  
  # /s/short_id
  get "/s/:id" => "s#show"
  #
  get "/s/:id/blog" => "s#blog"
  
  # /s/short_id/p/page_id
  get "/s/:id/p/:page_id" => "s#page"
  get "s/:id/p-:page_id" => "s#page"

  # /s/short_id/b/post_id
  get "/s/:id/b/:post_id" => "s#post"
  get "s/:id/b-:post_id" => "s#post" #all in s/:id/ can do cache.

  

  resources :themes

  resources :faq_items

  resources :faq_cates

  get "common/file_new"
  post "common/file_upload"
  resources :assets

  get "home/index"
  get "home/site"
  get "home/sms"
  get "home/email"
  get "home/data"
  get "home/pay"
  get "home/blog"
  get "home/qq"
  get "home/commerce"
  get "home/map"
  get "home/fenlei"
  get "home/forum"
  get "home/weibo"
  get "home/weixin"
  get "home/qa"
  get "home/wiki"
  get "home/video"
  get "home/mobile"
  get "home/setting"
  get "phone_import" => "phone_items#phone_import"
  get "mail_import" => "mail_items#mail_import"
  post "/phone_send" => "phone_items#phone_send", :via => :post
  post "/mail_send" => "mail_items#mail_send", :via => :post
  
  resources :mail_tmps

  resources :mail_items

  resources :sms_tmps

  resources :phone_items

  resources :sites do
    resources :site_comments
    resources :site_posts
    resources :site_pages
  end
  resources :site_pages
  resources :site_posts
  resources :site_comments
  resources :site_steps

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :user_details
  

  root :to => "home#index"
end