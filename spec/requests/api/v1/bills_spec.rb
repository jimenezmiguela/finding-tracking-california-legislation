require 'swagger_helper'

RSpec.describe 'api/v1/bills', type: :request do
# Initialize the test data
let(:user1) { FactoryBot.create(:user) }
let (:token){Warden::JWTAuth::UserEncoder.new.call(user1,:user,nil)}
let(:Authorization){ "Bearer "+ token[0]}

let!(:user) { FactoryBot.create(:user) }
let!(:bills) { FactoryBot.create_list(:bill, 20, user_id: user.id) }
let(:user_id) { user.id }
let(:fact_id) { bills.first.id }

path '/api/v1/users/{user_id}/bills' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get('list bills') do
    tags 'Bills'
    security [Bearer: {}]
    response(200, 'successful') do

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end

    post('create bill') do
    tags 'Bills'
    consumes 'application/json'
    produces 'application/json'
    security [Bearer: {}]
    parameter name: :bill, in: :body, required: true, schema: {
        type: :object,
        required: %i[measure subject author status],
        properties: {
        measure: {type: :string},
        subject: {type: :string},
        author: {type: :string},
        status: {type: :integer}
        }
    }
    response(201, 'successful') do
        let(:bill) { { measure: "AB100", subject: "Raising Wages", author: "Bill Wright", status: "Vetoed"} }

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end
end

path '/api/v1/users/{user_id}/bills/{bill_id}' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    parameter name: 'bill_id', in: :path, type: :string, description: 'id'

    get('show bill') do
    tags 'Bills'
    security [Bearer: {}]
    response(200, 'successful') do

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end

    patch('update bill') do
    tags 'Bills'
    consumes 'application/json'
    produces 'application/json'
    security [Bearer: {}]
    parameter name: :bill, in: :body, required: true, schema: {
        type: :object,
        properties: {
        measure: {type: :string},
        subject: {type: :string},
        author: {type: :string},
        status: {type: :integer}
        }
    }
    response(200, 'successful') do
        let(:bill) {{ measure: "This is another bill." }}

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end

    put('update bill') do
    tags 'Bills'
    consumes 'application/json'
    produces 'application/json'
    security [Bearer: {}]
        parameter name: :bill, in: :body, required: true, schema: {
        type: :object,
        properties: {
        measure: {type: :string},
        subject: {type: :string},
        author: {type: :string},
        status: {type: :integer}
        }
    }
    response(200, 'successful') do
        let(:bill) {{ measure: "This is another bill." }}

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end

    delete('delete fact') do
    tags 'Bills'
    security [Bearer: {}]
    response(200, 'successful') do

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end
end
end