class Authentication < ActiveRecord::Base
    belongs_to :user
    attr_accessible :provider, :uid, :user_id, :nickname, :name, :image, :url

    def self.update_authentication( user_source, auth )

        user_source.provider = auth[ 'provider' ]
        user_source.uid = auth[ 'uid' ]
        
        if ( auth[ 'provider' ] == 'google' )
            user_source.nickname = auth[ 'info' ][ 'email' ].gsub( '@gmail.com', '')
        else
            user_source.nickname = auth[ 'info' ][ 'nickname' ]
        end

        user_source.name = auth[ 'info' ][ 'name' ]
        user_source.image = auth[ 'info' ][ 'image' ].gsub( 'https', 'http' )
        
        if ( auth[ 'provider' ] == 'linkedin' )
            user_source.url = auth[ 'info' ][ 'urls' ][ 'public_profile' ]
        else
            user_source.url = auth[ 'info' ][ 'urls' ][ auth[ 'provider' ].humanize ]
        end

        if ( user_source.save )
            return( true )
        else
            return( false )
        end
    end

    def self.create_authentication( user_source, auth )
        if ( auth[ 'provider' ] == 'google' )
            nickname = auth[ 'info' ][ 'email' ].gsub( '@gmail.com' )
        else
            nickname = auth[ 'info' ][ 'nickname' ]
        end

        if ( auth[ 'provider' ] == 'linkedin' )
            url = auth[ 'info' ][ 'urls' ][ 'public_profile' ]
        elsif ( auth[ 'provider' ] == 'yahoo' )
            url = auth[ 'info' ][ 'urls' ][ 'Profile' ]
        else
            url = auth[ 'info' ][ 'urls' ][ auth[ 'provider' ].humanize ]
        end

        parameters = { 
            :provider => auth[ 'provider' ],
            :uid => auth[ 'uid' ],
            :nickname => nickname,
            :name => auth[ 'info' ][ 'name' ],
            :image => auth[ 'info'][ 'image' ],
            :url => url
        }
        
        if ( user_source.authentications.create!( parameters ) )
            return( true )
        else
            return( false )
        end
    end

    def self.oauth_new_user( auth )
        if ( auth[ 'provider' ] == 'facebook' )
            first_name = auth[ 'info' ][ 'first_name' ]
            last_name = auth[ 'info' ][ 'last_name' ]               
        else
            first_name = auth[ 'info' ][ 'name' ]
            last_name = ''
        end

        if ( auth[ 'provider' ] == 'facebook' )
            image = auth[ 'info' ][ 'image' ].gsub( 'square', 'large' )
        elsif ( auth[ 'provider' ] == 'twitter' )
            image = auth[ 'info' ][ 'image' ].gsub( '_normal', '' )
        else
            image = auth[ 'info' ][ 'image' ]
        end

        if ( auth[ 'provider' ] == 'google' )
            nickname = auth[ 'info' ][ 'email' ].gsub( '@gmail.com', '' )
        else
            nickname = auth[ 'info' ][ 'nickname' ]
        end

        if ( auth[ 'provider' ] == 'linkedin' )
            url = auth[ 'info' ][ 'urls' ][ 'public_profile' ]
        elsif ( auth[ 'provider' ] == 'yahoo' )
            url = auth[ 'info' ][ 'urls' ][ 'Profile' ]
        else
            url = auth[ 'info' ][ 'urls' ][ auth[ 'provider' ].humanize ]
        end
        
        parameters = {
            :login => nickname,
            :email => auth[ 'info' ][ 'email' ],
            :profile_attributes => {
                :first_name => first_name,
                :last_name => last_name,
                :remote_avatar_url => image,
                :role => 'user'
            },
            :authentication_attributes => {
                :uid => auth[ 'uid' ],
                :provider => auth[ 'provider' ],
                :nickname => nickname,
                :name => first_name,
                :image => image,
                :url => url
            }
        }

        return parameters
    end
end
