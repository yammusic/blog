class ProfilesController < ApplicationController
  # load_resource
  skip_authorize_resource :only => [ :index, :update_avatar, :update_profile, :profile, :avatar, :social, :account ]

  def index
    @user = User.find_by_params_profile( params )
    @profile = @user.profile

    respond_to do |format|
        #format.xml { render( { :xml => @profile } ) }
        #return
        format.html {
            if ( request.xhr? || !params[ :layout ].nil? )
                render( { :layout => false } )
            else
                render( :index ) # index.html.erb
            end
        }
        #format.js { render( { :js => 'alert( "Hello World!" );' } ) }
        format.js { render( :index ) } # index.js.erb
        format.json { render( { :json => @profile } ) }
        #format.xml { render( { :xml => @profile } ) }
        format.xml { render( :index ) } # index.xml.erb
    end
  end

  def method_missing( method, *args, &block )
    if ( method == :profile || method == :avatar || method == :social || method == :account )
      index
    else
      raise 'Unknown action'
    end
  end

  def update_avatar
    @profile = current_user.profile
    if ( @profile.update_attributes( params[ :user_profile ] ) )
      redirect_to( avatar_user_profiles_path( current_user ) )
    else
      render(:text => 'error al guardar imagen')
    end
  end

  def update_profile
    @profile = User.find( params[ :user_id ] ).profile
    if ( @profile.update_attributes( params[ :user_profile ] ) )
      redirect_to( profile_user_profiles_path( current_user ) )
    else
      render :text => params.inspect
    end
  end

end
