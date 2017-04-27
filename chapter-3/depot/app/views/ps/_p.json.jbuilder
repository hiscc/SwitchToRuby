json.extract! p, :id, :title, :description, :image_url, :price, :created_at, :updated_at
json.url p_url(p, format: :json)
