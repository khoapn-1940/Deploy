Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',omniauth_callbacks: "users/omniauth_callbacks"}
  scope "(:locale)", locale: /en|vi/ do

  root "pages#home"
  get "/error", to: "errors#handle404"
  # get "/signup", to: "users/registrations#new"
  # post "/signup", to: "users/registrations#create"
  # get "/login", to: " users/sessions#new"
  # post "/login", to: "sessions#create"
  # get "/logout", to: "users/sessions#destroy"
  get "/search", to: "pages#search"
  get "/view_my_booking", to: "self_management#view_my_booking"
  get "/view_my_review", to: "self_management#view_my_review"
  get "/view_my_information", to: "self_management#view_my_information"
  get "/view_other_user_information", to: "self_management#view_other_user_information"
  resources :self_management, only: [:edit, :update]
  resources :tour_details, only: [:show]
  resources :ratings, only: [:create]
  resources :bookings, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :reviews, only: [:create, :destroy]
  resources :users, only: [:new, :edit, :update, :create]
  resources :manage_users, only: [:new, :edit, :update]
  resources :payments, only: [:create]
  get "/recover_user", to: "admin/users#recover"

  namespace :admin do
    resources :users, except: []
    resources :reviews, except: []
    resources :categories, except: []
    resources :tours, except: []
    resources :tour_details, except: []
    resources :bookings, except: []
    resources :payments, only: [:index]

  end
end
end
