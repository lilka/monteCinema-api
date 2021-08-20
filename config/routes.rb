# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :movies, only: %i[index show]
  resources :cinema_halls, only: %i[index show update create destroy]
  resources :screenings, only: %i[index show update create]
  resources :reservations, only: %i[index show create]
  resources :seats, only: %i[index show destroy]

  resources :screenings do
    resources :seats
  end
end
