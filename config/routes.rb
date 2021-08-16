# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :movies, only: %i[index show]
  resources :cinema_halls, only: %i[index show update create destroy]
  resources :jsonapi, controller: 'jsonapi/cinema_halls'
end
