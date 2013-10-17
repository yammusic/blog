class AddCreatedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :created, :date
  end
end
