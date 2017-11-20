BsCheckout::Engine.routes.draw do
  root 'checkout#index'
  put 'checkout' => 'checkout#update_cart', as: :checkout_update
  resources :checkout
  resources :order_items, only: [:create, :destroy]
end
