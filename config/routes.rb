Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "custom_registration" }

  root 'about#home'

  resources :items, only: [:new, :create, :edit, :update, :destroy]
  resources :lists, only: [:index]
  patch 'lists' => 'lists#update', as: :update_lists
  resources :users, only: [:new]
  post 'associated_user' => 'users#create', as: :associated_user
  get 'facebook' => 'users#facebook', as: :facebook
  get 'dashboard' => 'users#dashboard', as: :dashboard
  get 'dashboard' => 'users#dashboard', as: :user_root

end
