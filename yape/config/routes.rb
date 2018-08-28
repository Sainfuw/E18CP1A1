Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show, :index]

  resources :products
  delete 'products/:id/sale', :to => 'products#sale', as: 'product_sale'

  resources :purchases, only: :index
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
