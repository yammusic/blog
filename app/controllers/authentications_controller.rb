class AuthenticationsController < ApplicationController

  skip_authorize_resource :only => [ :callback, :destroy_provider ]
  
  def callback
    auth = request.env[ "omniauth.auth" ]
    session[ :provider_user ] = auth[ 'info' ].to_hash
    session[ :provider_uid ] = auth[ 'uid' ]
    session[ :provider_name ] = auth[ 'provider' ].gsub( '_oauth2', '' )
    authentication = Authentication.find_by_provider_and_uid( auth[ 'provider' ].gsub( '_oauth2', '' ), auth[ 'uid' ] )
    auth_provider = current_user.authentications.find_by_provider( auth[ 'provider' ] )
    if( auth_provider )
      auth_provider.provider = auth[ 'provider' ].gsub( '_oauth2', '' )
      auth_provider.uid = auth[ 'uid' ]
      auth_provider.nickname = ( session[ :provider_name ] == 'google' ) ? session[ :provider_user ][ 'email' ].gsub( '@gmail.com', '') : session[ :provider_user ][ 'nickname' ]
      auth_provider.name = session[ :provider_user ][ 'name' ]
      auth_provider.image = session[ :provider_user ][ 'image' ].gsub( 'https', 'http' )
      auth_provider.url = session[ :provider_user ][ 'urls' ][ session[ :provider_name ].humanize ]
      auth_provider.save
      render( { :text => '<script>window.opener.location.href = "'+ social_user_profiles_path( current_user ) +'"; window.close(); </script>' } )
    elsif( current_user )
      current_user.authentications.create!(
        :provider => auth[ 'provider' ].gsub( '_oauth2', '' ),
        :uid => auth[ 'uid' ],
        :nickname => ( session[ :provider_name ] == 'google' ) ? session[ :provider_user ][ 'email' ].gsub( '@gmail.com', '') : session[ :provider_user ][ 'nickname' ],
        :name => session[ :provider_user ][ 'name' ],
        :image => session[ :provider_user ][ 'image' ].gsub( 'https', 'http' ),
        :url => session[ :provider_user ][ 'urls' ][ session[ :provider_name ].humanize ]
      )
      render( { :text => '<script>window.opener.location.href = "'+ social_user_profiles_path( current_user ) +'"; window.close(); </script>' } )
    else
      render :text => session.inspect
    end
    # session[ :user ] = auth[ 'user_info' ]
    # redirect_to( social_user_profiles_path( current_user ) )
  end

  def destroy_provider
    auth = current_user.authentications.find_by_uid( params[ :uid ] )
    auth.destroy
    session[ :provider_user ] = nil
    session[ :provider_uid ] = nil
    session[ :provider_provider ] = nil
    redirect_to( social_user_profiles_path( current_user ) )
  end

end
