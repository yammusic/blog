class ProfilesController < ApplicationController
  # load_resource
  skip_authorize_resource :only => [ :index ]

  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end
end
