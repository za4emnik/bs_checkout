Rails.application.routes.draw do
  devise_for :users

  mount BsCheckout::Engine => "/bs_checkout"

  as :user do
    get 'login'  => 'devise/sessions#new', as: :login
    get 'logout' => 'devise/sessions#destroy', as: :logout
    get 'signup' => 'devise/registrations#new', as: :signup
  end

  root 'home#index'
  resources :books,       only: [:show]
end
