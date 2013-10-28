RainService::Application.routes.draw do
  
  #Use for client side
  get "page/index"
  post "page/pcall"
  post "/pcall" => "page#pcall", :via => :post

  resources :phone_calls
  resources :user_accounts

  #for subdomain
  constraints(Subdomain) do
    get "/" => "s#show"

    #page: /p/:page_id
    get "/p/:page_id" => "s#page"
    get "/p-:page_id" => "s#page"
    #post: /p/:page_id/:post_id
    get "/p/:page_id/:post_id" => "s#page"
    #blog pagination: /p/:page_id/:page => /p/blog?page=3 || /p/blog/page/2
    get "/p/:page_id/page/:page" => "s#page"
  end

  #for dev
  get "/s/:id" => "s#show"

  resources :themes

  resources :faq_items

  resources :faq_cates

  #Use for server side.
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
  get "home/pcall"
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