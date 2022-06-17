class AddCommentsToIsHidden < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :is_hidden, :boolean, default: false, null: false
  end
end
