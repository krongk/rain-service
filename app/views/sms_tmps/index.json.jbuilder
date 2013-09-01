json.array!(@sms_tmps) do |sms_tmp|
  json.extract! sms_tmp, :user_id, :title, :content, :content_size
  json.url sms_tmp_url(sms_tmp, format: :json)
end
