Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'static_pages/index'
  root 'static_pages#index'

  resources :posts
  resources :projects
  resources :contacts, only: [:new, :create]

  get '*path'  => redirect('/')
end
