class UsersController < ApplicationController
    #load_and_authorize_resource

    def index
        @users = User.all
    end

    def show
        @user = User.find_by_params( params )
    end

    def edit
        @user = User.find_by_params( params )
    end

    def destroy
        @post = User.find_by_params( params )
        @post.destroy

        redirect_to( users_path )
    end
end
