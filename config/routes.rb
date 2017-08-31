Rails.application.routes.draw do


  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
  resources :movies do
    resources :reviews, except: [:show, :index]
  end

  resources :users , only: [:show] do
    get "/my_movies" => 'movies#my_movies', :as => 'my_movies'
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'movies#index'
end
