json.extract! contact, :id, :name, :address, :wechat, :facebook, :lat, :lng, :email, :phone, :mobile, :description, :created_at, :updated_at
json.url contact_url(contact, format: :json)
