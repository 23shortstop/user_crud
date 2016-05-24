Rails.application.routes.draw do

  namespace :api do
    resources :users, only: [:index, :create, :show, :update, :destroy]
    resource :sessions, only: [:create, :destroy]
    delete '/sessions', to: 'sessions#destroy'
  end

end
