Rails.application.routes.draw do
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :ps
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
