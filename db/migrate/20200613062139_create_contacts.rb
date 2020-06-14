class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :address
      t.string :wechat
      t.string :facebook
      t.string :lat
      t.string :lng
      t.string :email
      t.string :phone
      t.string :mobile
      t.string :cellcard
      t.string :metfone
      t.string :smart
      t.text :description

      t.timestamps
    end
  end
end
