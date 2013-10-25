class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :avatar
      t.string :role
      t.string :first_name
      t.string :last_name
      t.date :born
      t.integer :sex

      t.timestamps
    end
  end
end
