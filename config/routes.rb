Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  root 'about#home'

  resources :items, only: [:new, :create, :edit, :update, :destroy]
  resources :users, only: [:new]
  post 'associated_user' => 'users#create', as: :associated_user
  get 'facebook' => 'users#facebook', as: :facebook
  get 'dashboard' => 'users#dashboard', as: :dashboard
  get 'dashboard' => 'users#dashboard', as: :user_root

end
