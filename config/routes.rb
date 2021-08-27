# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'screenings#index'
  mount_devise_token_auth_for 'User', at: 'auth'
  
  resources :movies, only: %i[index show]
  resources :cinema_halls, only: %i[index show update create destroy]
  resources :screenings, only: %i[index show update create]
  resources :reservations, only: %i[index show create]
  resources :seats, only: %i[index show destroy]
  

  resources :screenings do
    resources :seats
  end
end
