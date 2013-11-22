class ApplicationController < ActionController::Base
	protect_from_forgery
    authorize_resource :unless => :authorize_resource_validator
    layout :set_layout

    before_filter :set_lang

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

    private
    def set_lang
        if ( user_signed_in? )
            I18n.locale = 'es'
        else
            I18n.locale = 'en'
        end
    end
end
