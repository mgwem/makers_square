class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.integer :member_id
      t.string :name
      t.string :store
      t.integer :price
      t.boolean :is_stocked, default: false, null: false

      t.timestamps
    end
  end
end
