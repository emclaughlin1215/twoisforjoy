Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      post 'login' => 'sessions#create'
      delete 'logout' => 'sessions#destroy'
      post 'authenticate', to: 'authentication#authenticate'
      resources :users, only: [:show, :edit, :update]
    end
  end
end
