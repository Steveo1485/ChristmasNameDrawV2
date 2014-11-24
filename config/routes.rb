Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  root 'about#home'

  resources :users, only: [:show]
  get 'facebook' => 'users#facebook', as: :facebook

  get 'dashboard' => 'users#dashboard', as: :dashboard
  get 'dashboard' => 'users#dashboard', as: :user_root

end
