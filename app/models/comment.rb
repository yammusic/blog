class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, :dependent => :destroy
  attr_accessible :body, :commenter, :created, :user_id
end
