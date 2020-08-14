Rails.application.routes.draw do
  resources :exercises
  post '/add_node' => 'exercise_nodes#add_node', as: 'add_node'
  delete '/delete_node' => 'exercise_nodes#delete_node', as: 'delete_node'

  get '/login' => 'users#login', as: 'login'
  post '/create' => 'users#create', as: 'create'
  get '/register' => 'users#register', as: 'register'
  get '/logout' => 'users#logout', as: 'logout'

  get '/home' => 'home#index', as: 'home'

  root 'exercises#index'
end
