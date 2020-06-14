json.extract! company, :id, :name, :address, :website, :phone_number, :lat, :lng, :photo, :created_at, :updated_at
json.url company_url(company, format: :json)
