json.array!(@sites) do |site|
  json.extract! site, :user_id, :site_name, :site_title, :domain, :theme_id, :head, :header, :body, :footer, :is_published
  json.url site_url(site, format: :json)
end
