require 'sidekiq/web'
require 'sidekiq-scheduler/web'
require "sidekiq/grouping/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
end
