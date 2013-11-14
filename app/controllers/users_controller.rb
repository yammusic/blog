class UsersController < ApplicationController
    #load_and_authorize_resource
    skip_authorize_resource :only => [ :update_password ]

    def index
        @users = User.all
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

    def update_password
        @user = User.find( current_user.id )
        if ( @user.update_attributes( params[ :password_user ] ) )
            sign_in( @user, { :bypass => true } )
            redirect_to( account_user_profiles_path( current_user ) )
        else
            render( :text => 'fail' )
        end
    end 
end
