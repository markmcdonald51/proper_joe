json.extract! media_link, :id, :text, :link, :linkableable_id, :linkableable_type, :position, :created_at, :updated_at
json.url media_link_url(media_link, format: :json)
