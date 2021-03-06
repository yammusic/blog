class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :authentications
  accepts_nested_attributes_for :comments
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :authentication_keys => [ :login ]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, :reset_password_token, :profile_attributes

  def self.find_first_by_auth_conditions( warden_conditions )
    conditions = warden_conditions.dup
    if login = conditions.delete( :login )
      where( conditions ).where( [ "lower(login) = :value OR lower(email) = :value", { :value => login.downcase } ] ).first
    else
      where( conditions ).first
    end
  end

  def role?( role )
    profile = self.profile
    return( false ) if ( profile.nil? )
    return( profile.role == role.to_s )
  end

  def to_param
    return( login.gsub( ' ', '-' ) )
  end

  def self.find_by_params( params )
    return( self.find_by_login( params[ :id ].gsub( '-', ' ' ) ) )
  end

  def self.find_by_params_profile( params )
    return( self.find_by_login( params[ :user_id ].gsub( '-', ' ' ) ) )
  end

  def self.user_info( user_login )
    return( self.find_by_login( user_login ) )
  end
end
