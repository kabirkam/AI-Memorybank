Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/profile", to: "pages#profile"
  get '/test', to: "pages#test"
  post '/transcript', to: "pages#voice_to_text"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :notes do
    resources :reminders
    resources :categories
  end
end
