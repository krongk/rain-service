RainService::Application.routes.draw do
  
  resources :user_accounts

  #for subdomain
  constraints(Subdomain) do
    get "/" => "s#show"
  
    get "/blog" => "s#blog"
    
    # /p/page_id
    get "/p/:page_id" => "s#page"
    get "/p-:page_id" => "s#page"

    # /b/post_id
    get "/b/:post_id" => "s#post"
    get "/b-:post_id" => "s#post" #all in s/:id/ can do cache.
  end

  #for dev
  get "/s/:id" => "s#show"

  resources :themes

  resources :faq_items

  resources :faq_cates

  get "common/file_new"
  post "common/file_upload"
  resources :assets

  get "home/index"
  get "home/theme"
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
  get "/like_theme" => "themes#like_theme"

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