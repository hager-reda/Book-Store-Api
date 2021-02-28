Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :books
      resources :authors, only: [:create]
      post "/login", to: "authors#login"      
      get "/auto_login", to: "authors#auto_login"      
    end
  end
  
end
