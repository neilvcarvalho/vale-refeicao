VR::Application.routes.draw do
  get "main/index"

  resources :sessions, only: [:create, :destroy]
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  root :to => 'inquiries#index'

  resources :inquiries, only: [:index, :create]
  resources :cards
end
