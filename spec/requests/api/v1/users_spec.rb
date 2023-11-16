require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
let(:user1) { FactoryBot.create(:user) }
let (:token){Warden::JWTAuth::UserEncoder.new.call(user1,:user,nil)}
let(:Authorization){ "Bearer "+ token[0]}
let!(:users) { FactoryBot.create_list(:user, 10) }
let(:user_id) { users.first.id }

path '/api/v1/users' do

    get('list users') do
    tags 'Users'
    produces 'application/json'
    security [Bearer: {}]
    response(200, 'successful') do
        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end

    post('create user') do
    tags 'Users'
    consumes 'application/json'
    produces 'application/json'
    security [Bearer: {}]
    parameter name: :user, in: :body, required: true, schema: {
        type: :object,
        required: %i[first_name last_name email password],
        properties: {
        first_name: { type: :string },
        last_name: { type: :string },
        email: { type: :string },
        password: { type: :string }
        }
    }

    response(201, 'successful') do
        let(:user) { { first_name: "r", last_name: "r", email:"r@r.com", password: "r"}}

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end
end

path '/api/v1/users/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
    tags 'Users'
    security [Bearer: {}]
    response(200, 'successful') do
        let(:id) { user_id }

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end

    patch('update user') do
    tags 'Users'
    consumes 'application/json'
    produces 'application/json'
    security [Bearer: {}]
    parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
        first_name: { type: :string },
        last_name: { type: :string },
        email: { type: :string },
        password: { type: :string }
        }
    }
    response(200, 'successful') do
        let(:id) { user_id }
        let(:user) {{first_name: 'fred'}}
        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end

    put('update user') do
    tags 'Users'
    consumes 'application/json'
    produces 'application/json'
    security [Bearer: {}]
    parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
        first_name: { type: :string },
        last_name: { type: :string },
        email: { type: :string },
        password: { type: :string }
        }
    }
    response(200, 'successful') do
        let(:id) { user_id }
        let(:user) {{first_name: 'fred'}}

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end

    delete('delete user') do
    tags 'Users'
    security [Bearer: {}]
    response(200, 'successful') do
        let(:id) { user_id }

        after do |example|
        example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
    end
    end
end
end