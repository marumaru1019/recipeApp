Rails.application.routes.draw do
  get "/" => "errors#not_found"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes
end
