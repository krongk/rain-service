json.array!(@faq_items) do |faq_item|
  json.extract! faq_item, :faq_cate_id, :title, :content
  json.url faq_item_url(faq_item, format: :json)
end
