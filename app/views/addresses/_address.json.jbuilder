json.extract! address, :id, :encrypted_address, :encrypted_postcode, :encrypted_landline, :created_at, :updated_at
json.url address_url(address, format: :json)