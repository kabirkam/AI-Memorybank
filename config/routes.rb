Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/test', to: "pages#test"
  post '/transcript', to: "pages#voice_to_text"
  post '/imagify', to: "pages#generate_imgs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :notes do
    resources :reminders
    resources :categories
  end
end
