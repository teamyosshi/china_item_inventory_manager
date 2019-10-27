Rails.application.routes.draw do
  root 'static_pages#top'
  post '/', to:'sessions#create'
  get '/signup',to:'users#new', as: :signup
  post   '/export',    to: 'stocks#csv_export'
  #delete :items, to: 'items#destroy_many'
  delete '/items/destroy_many', to: 'items#destroy_many'
  post '/stocks/update',    to: 'stocks#update'
  #get 'inventory_control_index', to:'stocks#inventory_control', as: :inventory_control
  get 'users/:id/inventory_control', to:'stocks#inventory_control', as: :inventory_control
  get 'users/:id/item_research', to:'researches#item_research', as: :item_research
  get 'users/:id/product_inventory', to:'stocks#product_inventory', as: :stock
  get'users/:id/research', to:'researches#stocking', as: :stocking
  get 'users/:id/product_scarce', to:'items#product_scarce', as: :product_scarce
  get 'users/:id/sold_out', to: 'stocks#sold_out', as: :sold_out
  get 'users', to: 'users#index', as: :index
  get 'users/:id/edit', to:'users#edit', as: :edit
  delete '/logout', to:'sessions#destroy'
  post "takeinventory/:id", to:'take_inventory#update', as: :takeinventory_update
  resources :researches
  resources :stocks
  resources :items do
    collection { post :import }
  end
  #スクレイピング
  get 'users/:id/item_research_scrape', to:'researches#item_research_scrape', as: :item_research_scrape
  resources :stocks
  resources :items
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
