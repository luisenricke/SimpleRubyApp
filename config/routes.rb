Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#index'

  # Auth routes
  devise_for :users
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
end
