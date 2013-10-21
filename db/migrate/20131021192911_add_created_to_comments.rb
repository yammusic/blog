class AddCreatedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :created, :date
  end
end
