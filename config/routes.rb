Rails.application.routes.draw do

  devise_for :users
  devise_for :models
  resources :wikis
  resources :charges, only: [:new, :create]

  get 'wikis/index'

  get 'users/confirm'

  get 'users/new'

  get 'users/show'

  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/support'

  get 'registrations/new'

  delete 'sessions/sign_out'

  get 'sessions/destroy'

  root 'welcome#index'

  get 'charges/upgrade'

  post 'charges/upgrade'
end
