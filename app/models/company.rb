class Company < ApplicationRecord
  has_many :homes
  has_many :agent_refs, class_name: 'Agent'
  has_many :agents, through: :agent_refs, source: :contact

  validates_presence_of :name
  validates_uniqueness_of :name

  geocoded_by :address, latitude: :lat, longitude: :lng
  #after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
end
