Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'devise/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "events#index"

  resources :events do
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]
    post :show, on: :member
  end
  resources :users, only: [:show, :edit, :update]
end
