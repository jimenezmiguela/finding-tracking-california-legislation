class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        attributes = [:first_name, :last_name,:email, :password]
        devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
        devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end

    private

    def respond_with(resource, _opts = {})
        register_success && return if resource.persisted?

        register_failed
    end

    def register_success
        render json: { message: 'Signing up sucessfully.' }, status: :created
    end

    def register_failed
        render json: { message: "Something went awry." }, status: :bad_request
    end

    def sign_up(resource_name, resource)
        #bypass the session store on the default implementation
        sign_in resource, store: false
    end
end


