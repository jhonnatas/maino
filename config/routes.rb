require 'sidekiq/web'
Rails.application.routes.draw do
  # This is necessary if you use Devise
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'home/index'
  devise_for :users

  root 'home#index'


  resources :posts do
    collection do
      post :import_txt
    end
      resources :comments   
  end
  resources :tags
end
