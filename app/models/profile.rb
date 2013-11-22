class Profile < ActiveRecord::Base
  belongs_to :users
  attr_accessible :avatar, :remote_avatar_url, :remove_avatar, :born, :first_name, :last_name, :role, :sex, :profile_attributes, :lang
  mount_uploader :avatar, AvatarUploader
end
