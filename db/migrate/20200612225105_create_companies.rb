class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, index: true
      t.string :address
      t.string :website
      t.string :phone_number
      t.decimal :lat
      t.decimal :lng
      t.string :photo
      t.string :email

      t.timestamps
    end
  end
end
