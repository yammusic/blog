class UsersController < ApplicationController
    #load_and_authorize_resource
    skip_authorize_resource :only => [ :update_user, :new, :new_user ]

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def new_user
        @user = User.new( params[ :user ] )
        if @user.save
            @user.profile.new( params[ :user ][ :profile ] ).save
            redirect_to( root_path )
        else
            render :text => 'error'
        end
    end

    def show
        @user = User.find_by_params( params )
    end

    def destroy
        @post = User.find_by_params( params )
        @post.destroy

        redirect_to( users_path )
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
