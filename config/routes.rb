Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post "/accounts/toggle" => "accounts#toggle"
  get "/terms"            => "static#terms"

  root to: "home#index" 
end
