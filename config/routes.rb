Rails.application.routes.draw do
  # Simple routes
  # (get|post|delete|patch) '/path' => 'controller#method'
  # get '/path/:id' => 'controller#method'

  resources :exercise
  root 'exercise#index'
end
