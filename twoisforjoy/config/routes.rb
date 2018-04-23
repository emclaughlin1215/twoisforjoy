Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post 'login' => 'sessions#create'
      delete 'logout' => 'sessions#destroy'
      resources :users, only: [:show, :edit, :update]
      resources :projects
      get 'projects/:tag', to: 'projects#index', as: :tag, :constraints  => { :tag => /[^\/]+/ }
    end
  end
end
