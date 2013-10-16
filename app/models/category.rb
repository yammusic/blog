class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts
  attr_accessible :name, :id

  def to_param
      name
  end

  def self.listNavAndFooter
      return self.order( "name ASC" ).all
  end
end
