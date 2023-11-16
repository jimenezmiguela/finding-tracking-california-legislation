require 'swagger_helper'

RSpec.describe 'user/registrations', type: :request do
    path '/users' do
            post 'create user' do
            tags 'Registrations'
            consumes 'application/json'
            produces 'application/json'
            parameter name: :user, in: :body, required: true, schema: {
                type: :object,
                required: %i[first_name last_name email password],
                properties: { user: { properties: {
                first_name: { type: :string },
                last_name: { type: :string },
                email: { type: :string },
                password: { type: :string }
                }}}
            }
            response(201, 'successful') do
                let(:user1) { FactoryBot.attributes_for(:user) }
                let(:user) do
                { user: {
                    first_name: user1[:first_name],
                    last_name: user1[:last_name],
                    email: user1[:email],
                    password: user1[:password]
                }}
                end
                after do |example|
                example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
                end
                run_test!
            end
        end
    end
end
