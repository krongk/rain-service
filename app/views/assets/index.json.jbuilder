json.array!(@assets) do |asset|
  json.extract! asset, :user_id, :asset_type, :asset_name, :asset_path, :bucket, :asset_key, :note, :return_hash
  json.url asset_url(asset, format: :json)
end
