Rails.application.routes.draw do
  root "pages#home"
  get "pages/about_us"

  get "runners/complete"
  get "runners/cancel"
  resources :subscribers

  # runners_root_path => "runners#edit"

  devise_for :runners, controllers: { registrations: "registrations" }

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  get "/payment", to: "runners#payment"

  resources :profiles do
    member do
      get "delete"
    end
  end

  resources :runners do
    member do
      get "delete"
    end
  end
end
