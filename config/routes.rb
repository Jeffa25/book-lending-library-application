Rails.application.routes.draw do
  root "books#index"

  resources :books, only: [:index, :show] do
    post "borrow", on: :member
    post "return", on: :member
  end

  resources :users, only: [:show]
end