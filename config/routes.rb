require 'sidekiq/web'
require 'sidekiq-scheduler/web'
require "sidekiq/grouping/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :shops do
    collection do
      get :download_pdf
    end
  end
  root 'shops#index'
end
