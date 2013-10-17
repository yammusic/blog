class Post < ActiveRecord::Base
  attr_accessible :text, :title, :id, :author, :created, :edited
  #has_and_belongs_to_many :categoriess
  #has_and_belongs_to_many :categories, :class_name => 'Categories'
  has_and_belongs_to_many :categories
  has_many :comments, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  validates :title, :presence => true, :length => { :minimum => 5 }

  def to_param
      return( title.gsub( ' ', '-' ) )
  end

  def self.find_by_params( params )
      return( self.find_by_title( params[ :id ].gsub( '-', ' ' ) ) )
  end
end
