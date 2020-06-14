class Home < ApplicationRecord
    belongs_to :company
    has_many :images, as: :linkableable, class_name: 'MediaLink'
    #geocoded_by :address, latitude: :lat, longitude: :lng
    #after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
end
