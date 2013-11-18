class Authentication < ActiveRecord::Base
    belongs_to :user
    attr_accessible :provider, :uid, :user_id, :nickname, :name, :image, :url

    def self.update_authentication( user_source, auth, session )
        if ( auth[ 'provider' ] == 'google_oauth2')
            user_source.provider = auth[ 'provider' ].gsub( '_oauth2', '' )
        else
            user_source.provider = auth[ 'provider' ]
        end

        user_source.uid = auth[ 'uid' ]
        
        if ( session[ :provider_name ] == 'google' )
            user_source.nickname = session[ :provider_user ][ 'email' ].gsub( '@gmail.com', '')
        else
            user_source.nickname = session[ :provider_user ][ 'nickname' ]
        end

        user_source.name = session[ :provider_user ][ 'name' ]
        user_source.image = session[ :provider_user ][ 'image' ].gsub( 'https', 'http' )
        
        if ( auth[ 'provider' ] == 'linkedin' )
            user_source.url = session[ :provider_user ][ 'urls' ][ 'public_profile' ]
        else
            user_source.url = session[ :provider_user ][ 'urls' ][ session[ :provider_name ].humanize ]
        end

        if ( user_source.save )
            return( true )
        else
            return( false )
        end
    end

    def self.create_authentication( user_source, auth, session )
        if ( auth[ 'provider' ] == 'google_oauth2' )
            provider = auth[ 'provider' ].gsub( '_oauth2', '' )
            nickname = session[ :provider_user ][ 'email' ].gsub( '@gmail.com' )

        else
            provider = auth[ 'provider' ]
            nickname = session[ :provider_user ][ 'nickname' ]
        end

        if ( auth[ 'provider' ] == 'linkedin' )
            url = session[ :provider_user ][ 'urls' ][ 'public_profile' ]
        else
            url = session[ :provider_user ][ 'urls' ][ session[ :provider_name ].humanize ]
        end

        parameters = { 
            :provider => provider,
            :uid => auth[ 'uid' ],
            :nickname => nickname,
            :name => session[ :provider_user ][ 'name' ],
            :image => session[ :provider_user][ 'image' ],
            :url => url
        }
        
        if ( user_source.authentications.create!( parameters ) )
            return( true )
        else
            return( false )
        end
    end
end
