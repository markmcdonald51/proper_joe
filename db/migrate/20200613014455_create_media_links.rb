class CreateMediaLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :media_links do |t|
      t.string :text
      t.string :link
      t.references :linkableable, polymorphic: true, null: false
      t.integer :position

      t.timestamps
    end
  end
end
