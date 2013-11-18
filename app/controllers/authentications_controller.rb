class AuthenticationsController < ApplicationController

  skip_authorize_resource :only => [ :callback, :destroy_provider ]
  
  def callback
    auth = request.env[ "omniauth.auth" ]
    session[ :provider_user ] = auth[ 'info' ].to_hash
    session[ :provider_uid ] = auth[ 'uid' ]
    session[ :provider_name ] = auth[ 'provider' ].gsub( '_oauth2', '' )
    auth_provider = current_user.authentications.find_by_provider( auth[ 'provider' ] )

    if( auth_provider )

      if ( Authentication.update_authentication( auth_provider, auth, session ) )
        render( { :text => '<script>window.opener.location.href = "'+ social_user_profiles_path( current_user ) +'"; window.close(); </script>' } )
      else
        raise 'error to update'
      end

    elsif( current_user )
      if ( Authentication.create_authentication( current_user, auth, session ) )
        render( { :text => '<script>window.opener.location.href = "'+ social_user_profiles_path( current_user ) +'"; window.close(); </script>' } )
      else
        raise 'error to update'
      end

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
