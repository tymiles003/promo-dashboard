json.array!(@access_codes) do |access_code|
  json.extract! access_code, :id, :user_id, :code
  json.url access_code_url(access_code, format: :json)
end
