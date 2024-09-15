Rails.application.routes.draw do
  get 'home/index'

  # Devise routes
  devise_for :users, controllers: {
    sessions: 'devise/sessions'
  }

  # Root route
  root 'home#index'

  # Resources for journal entries, tips, exercises, and professionals
  resources :journal_entries do
    collection do
      post :analyze
    end
  end

  resources :tips, only: [:index, :show]
  resources :exercises, only: [:index, :show]
  resources :professionals, only: [:index, :show]

  # Custom route for getting advice
  post 'get-advice', to: 'advice#create'
end
