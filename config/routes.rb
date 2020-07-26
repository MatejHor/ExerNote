Rails.application.routes.draw do
  resources :exercise_nodes
  resources :exercises
  # Simple routes
  # (get|post|delete|patch) '/path' => 'controller#method'
  # get '/path/:id' => 'controller#method'

  root 'exercises#index'
end
