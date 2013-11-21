class Post < ActiveRecord::Base
  attr_accessible :text, :title, :id, :author, :created, :edited, :description
  #has_and_belongs_to_many :categoriess
  #has_and_belongs_to_many :categories, :class_name => 'Categories'
  has_and_belongs_to_many :categories
  has_many :comments, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  validates :title, :presence => true, :length => { :minimum => 5 }
  accepts_nested_attributes_for :categories

  def to_param
      return( title.gsub( ' ', '-' ) )
  end

  def self.find_by_params( params )
      return( self.find_by_title( params[ :id ].gsub( '-', ' ' ) ) )
  end

  def self.find_by_params_has( params )
      return( self.find_by_title( params[ :post_id ].gsub( '-', ' ' ) ) )
  end

  def self.pagination( params, number = 10 )
    self.page( params[:page] ).per( number )
  end
end
