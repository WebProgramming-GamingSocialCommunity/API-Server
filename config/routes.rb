Rails.application.routes.draw do

  scope '/v1' do
    devise_for :users, :defaults => { :format => 'json' }, :controllers => { :sessions => "v1/sessions" }
  end

  namespace :v1, defaults: { format: :json } do
    get "/users/show" => "users#show", as: :user_url
    get "/posts/show" => "posts#show", as: :post_url
    resources :users
    resources :posts
    resource :login, only: [:create, :destroy], controller: :sessions
  end
end
