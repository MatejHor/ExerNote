Rails.application.routes.draw do
  resources :exercises
  post '/add_node' => 'exercise_nodes#add_node', as: 'add_node'

  # Simple routes
  # (get|post|delete|patch) '/path' => 'controller#method'
  # get '/path/:id' => 'controller#method'

  root 'exercises#index'
end
