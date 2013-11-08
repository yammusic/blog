class AuthenticationsController < ApplicationController
  
  def callback
    auth = request.env[ "omniauth.auth" ]
    render :text => auth.to_hash
    return
    session[ :provider_user ] = auth[ 'info' ].to_hash;
    authentication = Authentication.find_by_provider_and_uid( auth[ 'provider' ], auth[ 'uid' ] )
    if( authentication )
      render( { :text => '<script>window.opener.location.href = "'+ social_user_profiles_path( current_user ) +'"; window.close(); </script>' } )
    elsif( current_user )
      current_user.authentications.create!(
        :provider => auth[ 'provider' ],
        :uid => auth[ 'uid' ],
        :nickname => session[ :provider_user ][ 'nickname' ],
        :name => session[ :provider_user ][ 'name' ],
        :image => session[ :provider_user ][ 'image' ],
        :url => session[ :provider_user ][ 'urls' ][ 'Twitter' ]
      )
      render( { :text => '<script>window.opener.location.href = "'+ social_user_profiles_path( current_user ) +'"; window.close(); </script>' } )
    end
    # session[ :user ] = auth[ 'user_info' ]
    # redirect_to( social_user_profiles_path( current_user ) )
  end

end
