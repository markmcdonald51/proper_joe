class CreateHomes < ActiveRecord::Migration[6.0]
  def change
    create_table :homes do |t|
      t.string :home_type
      t.string :title
      t.text :description
      t.integer :khmer24_ad_id
      t.string :location
      t.date :posted
      t.integer :view
      t.integer :bedroom
      t.integer :bathroom
      t.integer :size
      t.integer :price
      t.string :facing
      t.references :company
      t.string :email

      t.timestamps
    end
    add_index :homes, [:lat, :lng]
  end
end
