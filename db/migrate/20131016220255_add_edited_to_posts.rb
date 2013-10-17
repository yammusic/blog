class AddEditedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :edited, :date
  end
end
