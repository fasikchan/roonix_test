Rails.application.routes.draw do
  root to: "grids#index"

  resources :grids, only: :index
  resources :departments
  resources :collaborators
end
