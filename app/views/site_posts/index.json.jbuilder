json.array!(@site_posts) do |site_post|
  json.extract! site_post, :user_id, :site_id, :title, :content, :key_words, :cate_id
  json.url site_post_url(site_post, format: :json)
end
