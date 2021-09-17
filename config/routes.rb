Rails.application.routes.draw do
  root :to => 'sessions#new'

  resources :dashboard
  get '/dashboard/:id', to: 'dashboard#show'

  resources :users
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'

  resources :quizzes
  match 'quiz' => 'quizzes#find_by_code', :via => :get

  #resources :matches
  get '/matches', to: 'matches#index'
  get '/matches/:match_id/player/:player_id', to: 'matches#players_show', as: :player_data
  get '/matches/:match_id', to: 'matches#match_show', as: :match
  post '/matches', to: 'matches#create'

  resources :players, only: [:create, :index]

  match 'authenticate' => 'authenticator#authenticate', :via => :post

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
