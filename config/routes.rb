Rails.application.routes.draw do
  get 'home/index'
  devise_for :users

  root 'home#index'

  resources :journal_entries
  resources :tips, only: [:index, :show]
  resources :exercises, only: [:index, :show]
  resources :professionals, only: [:index, :show]
end
