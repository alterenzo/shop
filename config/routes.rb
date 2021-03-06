Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "products#index"
  resource :products
  resource :cart_elements, only: [:create, :destroy]
  resource :carts, only: [:update]
end
