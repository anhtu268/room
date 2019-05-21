Rails.application.routes.draw do
  root "static_pages#home"

  get "/registration", to: "accounts#new"
  get "/profile", to: "accounts#show"
  get "/changepassword", to: "accounts#edit"
  get "/login", to: "sessions#new"

  post "/registration", to: "accounts#create"
  post "/login", to: "sessions#create"

  patch "/changepassword", to: "accounts#update"

  delete "/logout", to: "sessions#destroy"

  resources :account_activations, only: %i(edit)
  resources :password_resets, except: %i(show index destroy)

  resources :locations, only: %i(index show) do
    resources :reviews, only: %i(create destroy)
    resources :rooms, only: :show
    resources :reservations, only: %i(new create)
  end



  namespace :admin do
    resources(:users){get "search", on: :collection}
    resources(:location_types){get "search", on: :collection}
    resources(:services, except: :destroy){get "search", on: :collection}
    resources(:bed_details, except: :destroy){get "search", on: :collection}
    resources(:locations, only: %i(index show update)){get "search", on: :collection}

    root "static_pages#home"
  end

  namespace :manager do
    root "static_pages#home"
    resources :locations, except: :index do
      get "search", on: :collection
      resources :reviews, only: :index
      resources(:rooms, except: :destroy){get "search", on: :collection}
      resources(:reservations, only: %i(index update)) do
        get "search", on: :collection
        resources(:reservation_details, only: :index){get "search", on: :collection}
      end
    end
  end
end
