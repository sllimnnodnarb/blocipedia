Rails.application.routes.draw do

  devise_for :users
  devise_for :models
  resources :wikis
  resources :charges
  resources :wikis do
    resources :collaborators, only: [:index, :create, :destroy]
  end

  resources :users, only: [:show]

  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/support'

  get 'users/show'

  root 'welcome#index'

  get 'charges/upgrade'

  post 'charges/upgrade'

  post 'charges/downgrade'



end
