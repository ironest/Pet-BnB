Rails.application.routes.draw do
  devise_for :users, path: "/"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "pages#home", as: "root"

  get "/pets", to: "pets#index", as: "pets"
  get "/pets/new", to: "pets#new", as: "new_pet"
  post "/pets", to: "pets#create"
  get "/pets/:id", to: "pets#show", as: "pet"
  get "/pets/:id/edit", to: "pets#edit", as: "edit_pet"
  put "/pets/:id", to: "pets#update"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"  

  get "/bookings", to: "bookings#index", as: "bookings"
  get "/petsitters/:id/bookings/new", to: "bookings#new", as: "new_booking"
  post "/bookings", to: "bookings#create"
  get "/bookings/:id", to: "bookings#show", as: "booking"
  patch "/bookings/:id/accept", to: "bookings#accept", as: "accept_booking"
  patch "/bookings/:id/reject", to: "bookings#reject", as: "reject_booking"
  get "/bookings/:id/success", to: "bookings#success", as: "success_booking"
  post "/bookings/webhook", to: "bookings#webhook", as: "complete_booking"

  get "/petsitters", to: "petsitters#index", as: "petsitters"
  get "/petsitters/new", to: "petsitters#new", as: "new_petsitter"
  post "/petsitters", to: "petsitters#create"
  get "/petsitters/:id", to: "petsitters#show", as: "petsitter"
  get "/petsitters/:id/edit", to: "petsitters#edit", as: "edit_petsitter"
  put "/petsitters/:id", to: "petsitters#update"
  patch "/petsitters/:id", to: "petsitters#update"
  delete "/petsitters/:id", to: "petsitters#destroy"

end
