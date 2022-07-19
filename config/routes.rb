Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    get '/entities' => 'entities#index'
    post '/entities' => 'entities#create'
  end
end
