Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup',to:'users#new', as: :signup
  get 'users/:id/Inventory_control', to:'stocks#Inventory_control', as: :inventory_control
  get 'users/:id/item_research', to:'researches#item_research', as: :item_research
  get 'users/:id/product_inventory', to:'stocks#product_inventory', as: :stock
  get'users/:id/reseach', to:'reseachs#stocking', as: :stocking
  get 'users/:id/product_scarce', to:'items#product_scarce', as: :product_scarce
  get 'users/:id/sold_out', to: 'stocks#sold_out', as: :sold_out
  get 'users', to: 'users#index', as: :index
  get 'users/:id/edit', to:'users#edit', as: :edit

  resources :researches
  resources :stocks
  resources :items
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
