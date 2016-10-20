Rails.application.routes.draw do

  get 'notifications/index'

  root 'topics#index'
  resources :topics
  resources :comments, only: [:create, :edit, :update, :destroy]

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :conversations do
    resources :messages
  end
  resources :users, only: [:index, :show, :edit, :updates]
  resources :relationships, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
