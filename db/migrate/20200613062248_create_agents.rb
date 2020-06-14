class CreateAgents < ActiveRecord::Migration[6.0]
  def change
    create_table :agents do |t|
      t.references :company
      t.references :contact

      t.timestamps
    end
  end
end
