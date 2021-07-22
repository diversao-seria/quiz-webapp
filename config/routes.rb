Rails.application.routes.draw do
  root :to => 'sessions#new'

  resources :dashboard
  get '/dashboard/:id', to: 'dashboard#show'
  get '/dashboard/:id/alunos', to: 'dashboard#list'

  resources :users
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'

  resources :quizzes
  match 'quiz' => 'quizzes#find_by_code', :via => :get

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
