class AuthenticationsController < ApplicationController

  skip_authorize_resource :only => [ :callback, :destroy_provider ]
  
  def callback
    auth = request.env[ "omniauth.auth" ]
    auth[ 'provider' ] = auth[ 'provider' ].gsub( '_oauth2', '' )
    auth[ 'info' ] = auth[ 'info' ].to_hash

    if ( user_signed_in? )
      auth_provider = current_user.authentications.find_by_provider_and_uid( auth[ 'provider' ], auth[ 'uid' ] )

      if ( !auth_provider.nil? )

        if ( Authentication.update_authentication( auth_provider, auth ) )
          render( { :text => '<script>window.opener.location.href = "'+ social_user_profiles_path( current_user ) +'"; window.close(); </script>' } )
        else
          raise 'error to update'
        end

      else

        if ( Authentication.create_authentication( current_user, auth ) )
          render( { :text => '<script>window.opener.location.href = "'+ social_user_profiles_path( current_user ) +'"; window.close(); </script>' } )
        else
          raise 'error to update'
        end

      end

    else
      auth_user = Authentication.find_by_provider_and_uid( auth[ 'provider' ], auth[ 'uid' ] )

      if ( !auth_user.nil? )
        @user = User.find( auth_user.user_id )
        sign_in( @user, { :bypass => true } )
        render( { :text => '<script>window.opener.location.href = "/"; window.close(); </script>' } )
      else
        new_auth = Authentication.oauth_new_user( auth )
        render( { :text => '<script>window.opener.location.href = "'+ new_user_path( :user => new_auth ) +'"; window.close(); </script>' } )
      end
      
    end

    return



    if( auth_provider )

      if ( Authentication.update_authentication( auth_provider, auth ) )
        render( { :text => '<script>window.opener.location.href = "'+ social_user_profiles_path( current_user ) +'"; window.close(); </script>' } )
      else
        raise 'error to update'
      end

    elsif( current_user )
      if ( Authentication.create_authentication( current_user, auth ) )
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

  def filter_provider( provider )
    if ( provider == 'facebook' )
      redirect_to( '/auth/facebook' )
    elsif ( provider == 'twitter' )
      redirect_to( '/auth/twitter' )
    elsif ( provider == 'google_oauth2' )
      redirect_to( '/auth/google_oauth2' )
    elsif ( provider == 'linkedin' )
      redirect_to( '/auth/linkedin' )
    elsif ( provider == 'yahoo' )
      redirect_to( '/auth/yahoo' )
    end

  end

end
