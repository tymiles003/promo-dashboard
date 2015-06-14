json.array!(@access_codes) do |access_code|
  json.extract! access_code, :id, :user_id, :code, :invitee_name, :invitee_url, :invitee_info
  json.url access_code_url(access_code, format: :json)
end
