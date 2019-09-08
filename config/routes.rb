Rails.application.routes.draw do
  resources :researches
  resources :stocks
  resources :items
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
