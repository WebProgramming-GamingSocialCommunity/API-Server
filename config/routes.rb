Rails.application.routes.draw do
  devise_for :users, only: []

  namespace :v1, defaults: { format: :json } do
    get "/users/show" => "users#show", as: :user_url
    get "/posts/show" => "posts#show", as: :post_url
    resources :users
    resources :posts
    resource :login, only: [:create, :destroy], controller: :sessions
  end
end
