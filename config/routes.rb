Rails.application.routes.draw do
  get 'dashboard/index'
  root to: "projects#index"

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'projects#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :destroy, :update]
    post 'users/:id/toggle_role' => 'users#toggle_role'
  end

  resources :projects do
    resources :tickets do
      resources :comments
    end
  end
end
