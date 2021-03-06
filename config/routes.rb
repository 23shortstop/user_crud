Rails.application.routes.draw do

  namespace :api do
    resources :users, only: [:index, :create, :show, :update, :destroy]
    resource :session, only: [:create, :destroy]
    resources :images, only: [:index, :create, :show, :update, :destroy]
    resources :tasks, only: [:index, :create, :show]
  end

end
