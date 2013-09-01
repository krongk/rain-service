json.array!(@mail_tmps) do |mail_tmp|
  json.extract! mail_tmp, :user_id, :title, :content
  json.url mail_tmp_url(mail_tmp, format: :json)
end
