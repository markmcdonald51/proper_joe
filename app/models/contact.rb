class Contact < ApplicationRecord
    validates_uniqueness_of :email
    has_many :agencies, class_name: 'Agent'
    has_many :companies, through: :agencies
end
