Rails.application.routes.draw do
  resources :users
  resources :quizzes

  match 'quiz' => 'quizzes#find_by_code', :via => :get

  get 'show_question', to: 'questions#show_question'
  get 'remove_question', to: 'questions#remove_question'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
