class AddLangToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :lang, :string
  end
end
