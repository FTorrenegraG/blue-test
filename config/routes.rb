require 'sidekiq/web'
Rails.application.routes.draw do
  resources :page_urls, only: [:create, :index]
  get ':id', to: 'page_urls#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
end
