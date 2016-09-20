json.extract! patron, :id, :name, :description, :created_at, :updated_at
json.url patron_url(patron, format: :json)