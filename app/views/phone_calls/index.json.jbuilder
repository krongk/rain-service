json.array!(@phone_calls) do |phone_call|
  json.extract! phone_call, :user_id, :domain, :from_ip, :from_url, :from_phone, :is_processed, :note
  json.url phone_call_url(phone_call, format: :json)
end
