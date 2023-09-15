Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  scope "(:locale)", locale: /en|vi/ do
    get "static_pages/home"
    get "static_pages/help"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
    resources :account_activations, only: :edit
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  # Defines the root path route ("/")
  # root "articles#index"
end
