class AddNicknameAndNameAndImageAndUrlToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :nickname, :string
    add_column :authentications, :name, :string
    add_column :authentications, :image, :string
    add_column :authentications, :url, :string
  end
end
