class Categories < ActiveRecord::Base
  has_and_belongs_to_many :posts
  attr_accessible :name, :id
  accepts_nested_attributes_for :posts
end
