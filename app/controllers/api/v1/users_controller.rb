class Api::V1::UsersController < ApplicationController

    include(AuthenticationCheck)

    before_action(:is_user_logged_in)
    before_action(:find_user, :only => [:show, :update, :destroy])

    #GET /users
    def index
        @users = User.all
        render(:json => @users)
    end

    # GET /users/:id
    def show
        # @user = user.find(params[:id])
        if @user = User.find(params[:id])
        render( :json => @user,
                :status => 200)
        # 200:  successfully found it
        else
        render(:json => {
                            :error => "Unable to show user:
                            #{@user.errors.full_messages.to_sentence}"
                        },
                :status => 204)
            # No content
        end

        end

    #POST /users
    def create
        @user = User.new(user_params)
        if @user.save
        render(:json => @user, :status => 201)
        else
        render( :json =>  {
                            :error =>
                            "Could not create user: #{@user.errors.full_messages.to_sentence}"
                            },
                :status => 400
                )
        end
    end

    #PUT /users/:id
    def update

        if @user.update(user_params)
        render( :json => @user)
        else
        render( :json => {
                            :error => "Could not update user:
                            #{@user.errors.full_messages.to_sentence}"
                            },
                :status => 404)
        end

    end

    #DELETE /users/:id
    def destroy
        @user.destroy
        render( :json =>  {
                            :message => 'Deleted user successfully.'
                        },
                :status => 200
            )
    end

    private

        def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :category)
        end

        def find_user
        @user = User.find(params[:id])
        end

    end

