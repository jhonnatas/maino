Rails.application.routes.draw do
  get 'tags/index'
  get 'tags/show'
  get 'tags/new'
  get 'tags/edit'
  get 'tags/create'
  get 'tags/update'
  get 'tags/destroy'
  get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  resources :posts do
    resources :comments
  end

  resources :tags
end
