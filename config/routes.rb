Rails.application.routes.draw do
  resources :users
  resources :quizzes

  match 'quiz' => 'quizzes#find_by_code', :via => :get

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
