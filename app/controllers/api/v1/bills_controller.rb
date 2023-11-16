class Api::V1::BillsController < ApplicationController

    include(AuthenticationCheck)

    before_action(:is_user_logged_in)
    before_action(  :find_user,
                    :only => [:index, :show, :create, :update]
                    )
    before_action(  :find_bill,
                    :only => [:show, :update, :destroy]
                    )

    #GET /users/:user_id/bills
    def index
        render(:json => @user.bills)
    end

    def show
        # @user = user.find(params[:user_id])
        @bill = @user.bills.find(params[:id])
        if @bill = @user.bills.find(params[:id])
        render( :json => @bill, :status => 200)
        # 200:  successfully found it
        else
        render(:json => {
                            :error => "Unable to show bill:
                            #{@bill.errors.full_messages.to_sentence}"
                        },
                :status => 204)
        end
    end

    #POST /users/:user_id/bills
    def create
        @bill = @user.bills.new(bill_params)
        if @bill.save
        render( :json => @bill,
                :status => 201
                )
        else
        render( :json =>  {  :error =>
                                "Could not create bill.
                                    #{@bill.errors.full_messages.to_sentence}"
                                    #EX ['one', 'two', 'three'].to_sentence
                                    # => "one, two, and three"
                            },
                :status => 400
                )
        end
    end

    # PUT /users/:user_id/bills/:id
    def update
        # @user = user.find(params[:user_id])
        @bill = @user.bills.find(params[:id])
        if @bill.update(bill_params)

        render(:json => @bill)

        else
        render(:json => {
                            :error => "Unable to update bill:
                            #{@bill.errors.full_messages.to_sentence}"
                        },
                :status => 404)
        end
    end

    #DELETE /users/:user_id/bills/:id
    def destroy
        @bill.destroy
        render( :json => {
                        :message => 'Deleted bill sucessfully.'
                        },
                :status => 200)
    end

    private

    def bill_params
        params.require(:bill).permit(:measure, :subject, :author, :status, :summary, :vote, :appropriation, :fiscal_committee, :local_program, :high_priority, :category)
    end

    def find_user
        @user = User.find(params[:user_id])
    end

    def find_bill
        @bill = Bill.find(params[:id])
    end

end

