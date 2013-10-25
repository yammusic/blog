class ProfilesController < ApplicationController
  # load_resource
  skip_authorize_resource :only => [ :index ]

  def index
    @user = User.find_by_params_profile( params )
    @profile = @user.profile
  end
end
