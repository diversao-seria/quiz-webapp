Rails.application.routes.draw do
  root :to => 'sessions#new'

  resources :dashboard
  get '/dashboard/:id', to: 'dashboard#show'

  resources :users
  get '/users/:user_id' => 'sessions#index'
  post '/users', to: 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'

  resources :quizzes
  get '/quizzes/:user_id', to: 'quizzes#index'
  match 'quiz' => 'quizzes#find_by_code', :via => :get
  delete '/quizzes', to: 'quizzes#destroy'

  #resources :matches
  get '/matches/(:match_id)', to: 'matches#index'
  get '/matches/player/(:player_id(:match_id))', to: 'matches#players_show', as: :player_data
  post '/matches', to: 'matches#create'

  resources :players, only: [:create, :index]

  match 'authenticate' => 'authenticator#authenticate', :via => :post

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
