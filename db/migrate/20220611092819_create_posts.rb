class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :member_id
      t.integer :genre_id
      t.string :title
      t.text :explanation
      t.boolean :is_pubulished, default: true
      t.boolean :is_hidden, default: false

      t.timestamps
    end
  end
end
