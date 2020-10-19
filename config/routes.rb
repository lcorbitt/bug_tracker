Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations"}

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

  get 'dashboard/index'
  get 'tickets/index'
  get 'users/edit'
end
