json.array!(@faq_cates) do |faq_cate|
  json.extract! faq_cate, :typo, :name, :is_auth
  json.url faq_cate_url(faq_cate, format: :json)
end
