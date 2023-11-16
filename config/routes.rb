Rails.application.routes.draw do
 
  devise_for :users,
              controllers: {
                  sessions: 'users/sessions',
                  registrations: 'users/registrations'
              }
              
  get '/test', to: 'test#show'

  namespace :api do
    namespace :v1 do
      resources :users do
          resources :bills
      end
      resources(:measures, :only => :index)
      resources(:text, :only => :index)
    end
  end
end
