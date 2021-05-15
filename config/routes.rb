Rails.application.routes.draw do
  root :to => 'sessions#new'

  resources :users
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'

  resources :quizzes
  match 'quiz' => 'quizzes#find_by_code', :via => :get

  get 'show_question', to: 'questions#show_question'
  get 'remove_question', to: 'questions#remove_question'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
