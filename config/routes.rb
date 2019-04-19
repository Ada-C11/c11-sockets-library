Rails.application.routes.draw do
  root "books#index"

  # get "/books", to: "books#index", as: "books"
  # post "/books", to: "books#create"

  # get "/books/new", to: "books#new", as: "new_book"
  # get "/books/:id", to: "books#show", as: "book"

  # get "/books/:id/edit", to: "books#edit", as: "edit_book"
  # patch "/books/:id", to: "books#update"
  # delete "/books/:id", to: "books#destroy"

  resources :books #, except: [:destroy]

  resources :authors do
    # Why only index and new?
    resources :books, only: [:index, :new]
  end
end
