class TestController < ApplicationController
    include AuthenticationCheck

    before_action :is_user_logged_in

    def show
        render json: { message: "Welcome, you are logged in." },
        status: :ok
    end
end

