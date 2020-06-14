class MediaLink < ApplicationRecord
  belongs_to :linkableable, polymorphic: true
  include RailsSortable::Model
  set_sortable :position  # Indicate a sort column
end
