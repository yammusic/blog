class Profile < ActiveRecord::Base
  attr_accessible :avatar, :born, :first_name, :last_name, :role, :sex
  belongs_to :users
  mount_uploader :avatar, AvatarUploader
end
