class CreatePostMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :post_materials do |t|
      t.integer :post_id
      t.integer :material_id

      t.timestamps
    end
  end
end
