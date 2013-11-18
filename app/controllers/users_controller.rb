class UsersController < ApplicationController
    #load_and_authorize_resource
    skip_authorize_resource :only => [ :update_user, :new, :create_user, :destroy ]

    def index
        @users = User.all
    end

    def new
        @user = User.new
        @profile = @user.build_profile
    end

    def create_user
        @user = User.new(
            :login => params[ :user ][ 'login' ],
            :email => params[ :user ][ 'email' ],
            :password => params[ :user ][ 'password' ],
            :password_confirmation => params[ :user ][ 'password_confirmation' ]
        )
        @profile = @user.build_profile( params[ :user ][ :profile ], :role => 'user' )
        if @user.save!
            sign_in( @user, { :bypass => true } )
            redirect_to( user_profiles_path( @user ) )
        else
            render :text => 'error'
        end
    end

    def show
        @user = User.find_by_params( params )
    end

    def destroy
        @user = User.find( params[ :user_id ] )
        @user.destroy

        if ( current_user )
            if ( current_user.profile.role == 'super_admin' )
                redirect_to( users_path )
            end
        else
            redirect_to( root_path )
        end
    end

    def password
        render :text => 'hi'
    end

    def update_user
        @user = User.find( current_user.id )
        if ( @user.update_attributes( params_update( params ) ) )
            sign_in( @user, { :bypass => true } )
            redirect_to( account_user_profiles_path( @user ) )
        else
            render( :text => 'fail' )
        end
    end

    private
    def params_update( params )
        if ( !params[ :password_user ].nil? )
            return( params[ :password_user ] )
        elsif ( !params[ :account_user ].nil? )
            return( params[ :account_user ] )
        end
    end
end
