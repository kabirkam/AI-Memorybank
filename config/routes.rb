Rails.application.routes.draw do
  devise_scope :user do
    authenticated :user do
      root 'notes#new', as: :authenticated_root
    end

  get "/profile", to: "pages#profile"
  get '/test', to: "pages#test", as: 'test'
  post '/transcript', to: "notes#voice_to_text"
  post '/imagify', to: "notes#generate_imgs"
  patch '/like_image', to: "sentences#like_sentence"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :notes do
    resources :reminders
    resources :categories
  end
end
end
