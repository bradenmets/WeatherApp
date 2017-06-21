Rails.application.routes.draw do
  #resources :locations
  get '/:zipcode', to: 'locations#index'
  get '/search/:zipcode', to: 'locations#show'
  root to: 'locations#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
