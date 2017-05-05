Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles do
    resources :comments
  end
  resources :users
end
