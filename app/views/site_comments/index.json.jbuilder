json.array!(@site_comments) do |site_comment|
  json.extract! site_comment, :site_id, :name, :mobile_phone, :email, :content, :is_processed
  json.url site_comment_url(site_comment, format: :json)
end
