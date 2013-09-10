json.array!(@themes) do |theme|
  json.extract! theme, :name, :cate, :tags, :templete_image, :templete_url, :default_pages
  json.url theme_url(theme, format: :json)
end
