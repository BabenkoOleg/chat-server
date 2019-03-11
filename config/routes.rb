Rails.application.routes.draw do
  namespace :api do
    get '/auth', to: 'auth#show'
    post '/auth', to: 'auth#create'

    resources :users, only: [:create]
  end
end
