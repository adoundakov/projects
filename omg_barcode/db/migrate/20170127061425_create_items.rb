class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false, unique: true, index: true
      t.integer :upc, null: false, unique: true
      t.timestamps
    end

    add_index :items, [:upc, :name]
  end
end
