Rails.application.routes.draw do
  root 'static_pages#top'
  post '/', to:'sessions#create'
  get '/signup',to:'users#new', as: :signup
  post   '/export',    to: 'stocks#csv_export', as: :csv_export
  post   '/scarcecsv_export',    to: 'items#csv_scarceexport'
  post   '/soldoutcsv_export',    to: 'items#csv_soldoutexport'
  get    '/stocks/:id/stock_new', to:'stocks#stock_new'
  post '/stocks/buyitem_edit', to:'stocks#buyitem_edit',as: :buyitem_edit
  delete '/stocks/buyitem_delete', to:'stocks#buyitem_delete',as: :buyitem_delete
  post 'items/item_number',    to: 'items#product_item_number'
  put '/stocks/manynewbuyitem',    to: 'stocks#manynewbuyitem' 
  delete '/items/destroy_many', to: 'items#destroy_many'
  post '/stocks/update',    to: 'stocks#update'
  post '/stocks/stock_new',    to: 'stocks#stock_new', as: :stock_new
  #get 'inventory_control_index', to:'stocks#inventory_control', as: :inventory_control
  get 'users/:id/inventory_control', to:'stocks#inventory_control', as: :inventory_control
  get 'users/:id/buyitem', to:'stocks#buyitem', as: :buyitem
  get 'users/:id/item_research', to:'researches#item_research', as: :item_research
  get 'users/:id/product_inventory', to:'stocks#product_inventory', as: :stock
  get'users/:id/research', to:'researches#stocking', as: :stocking
  get 'users/:id/product_scarce', to:'items#product_scarce', as: :product_scarce
  get 'users/:id/sold_out', to: 'items#sold_out', as: :sold_out
  get 'users', to: 'users#index', as: :index
  get 'users/:id/edit', to:'users#edit', as: :edit
  delete '/logout', to:'sessions#destroy'
  post "takeinventory/:id", to:'take_inventory#update', as: :takeinventory_update
  get "/items/product_registration", to: 'items#product_registration', as: :product_registration
  patch "/researches/:id/update", to: "researches#update_resarch", as: :research_update
  patch "/items/:id/price_update", to: "items#price_update", as: :price_update
  patch "/items/:id/buyitems_price_update", to: "items#buyitems_price_update", as: :buyitems_price_update
    resources :researches
  resources :stocks
  resources :items
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
