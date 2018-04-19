Rails.application.routes.draw do
  
  resources :projects
  namespace :api do
    namespace :v1 do
      post 'login' => 'sessions#create'
      delete 'logout' => 'sessions#destroy'
      resources :users, only: [:show, :edit, :update]
    end
  end
end
