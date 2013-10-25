class ApplicationController < ActionController::Base
	protect_from_forgery
    authorize_resource :unless => :authorize_resource_validator

    #=================================
    # authorize_resource_validator
    #=================================
    def authorize_resource_validator
        return( devise_controller? )
    end
end
