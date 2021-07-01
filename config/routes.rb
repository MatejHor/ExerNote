Rails.application.routes.draw do
  # Exercises
  resources :exercises

  # Exercise nodes
  post '/add_node' => 'exercise_nodes#add_node', as: 'add_node'
  delete '/delete_node' => 'exercise_nodes#delete_node', as: 'delete_node'

  # User
  get '/login' => 'users#login', as: 'login'
  post '/create' => 'users#create', as: 'create'
  get '/register' => 'users#register', as: 'register'
  get '/logout' => 'users#logout', as: 'logout'

  # SearchExercises
  get '/search/index' => 'search_exercises#index', as: 'search_index'

  # Home
  get '/home' => 'home#index', as: 'home'
  root 'exercises#index'
end
