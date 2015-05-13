json.array!(@resources) do |post|
  json.extract! post, :id, :title, :user_id, :url, :content
  json.url post_url(post, format: :json)
end
