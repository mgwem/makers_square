class RenameIsPubulishedColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :is_pubulished, :is_published
  end
end
