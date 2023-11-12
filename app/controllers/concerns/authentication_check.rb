module AuthenticationCheck
    extend ActiveSupport::Concern

    def is_user_logged_in
        if current_user.nil?
            render json: { message: "There are no users logged in." },
            status: :unauthorized
        end
    end
end