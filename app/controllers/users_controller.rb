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
        params[ :user ][ :profile_attributes ][ :role ] = 'user'
        @user = User.new( params[ :user ] )
        @profile = @user.build_profile( params[ :user ][ :profile_attributes ] )
        if @user.save!
            sign_in( @user, { :bypass => true } )
            if ( !params[ :session_post ].nil? )
                redirect_to( post_path( params[ :session_post ], :anchor => 'comment-anchor' ) )
            else
                redirect_to( user_profiles_path( @user ) )
            end
        else
            render :text => 'error al crear usuario'
        end
    end

    def edit
        @user = User.find_by_params( params )
    end

    def update
        @user = User.find_by_params( params )
        if ( @user.update_attributes( params[ :user ] ) )
            redirect_to( users_path )
        else
            render :text => 'error al modificar usuario'
        end
    end

    def show
        @user = User.find_by_params( params )
    end

    def destroy
        @user = User.find( params[ :user_id ] )
        @user.profile.destroy
        @user.comments.all.map do | c |
            c.destroy
        end
        @user.authentications.all.map do | a |
            a.destroy
        end
        @user.destroy

        if ( user_signed_in? )
            if ( current_user.profile.role == 'super_admin' )
                redirect_to( users_path )
            end
        else
            redirect_to( root_path )
        end
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
