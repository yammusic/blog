class Authentication < ActiveRecord::Base
    belongs_to :user
    attr_accessible :provider, :uid, :user_id, :nickname, :name, :image, :url
end
