class ApplicationController < ActionController::Base
	protect_from_forgery
    authorize_resource :unless => :authorize_resource_validator
    layout :set_layout

    #=================================
    # authorize_resource_validator
    #=================================
    def authorize_resource_validator
        return( devise_controller? )
    end

    #=================================
    # set_layout
    #=================================
    def set_layout
        layout = 'application'

        if ( request.xhr? )
            layout = false
        end

        return( layout )
    end
end
