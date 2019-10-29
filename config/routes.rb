Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "pages#home", as: "root"

  get "/pets", to: "pets#index", as: "pets"
  get "/pets/:id", to: "pets#show", as: "pet"

  get "/bookings", to: "bookings#index", as: "bookings"
  get "/bookings/:id", to: "bookings#show", as: "booking"

  get "/petsitters", to: "petsitters#index", as: "petsitters"
  get "/petsitters/:id", to: "petsitters#show", as: "petsitter"
  get "/petsitters/new", to: "petsitters#new", as: "new_petsitter"

end
