Rails.application.routes.draw do
  resources :movies, only: %i[index show]
  resources :cinema_halls, only: %i[index show]
end
