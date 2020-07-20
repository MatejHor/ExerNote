Rails.application.routes.draw do

  resources :exercise


  root 'exercise#show'
end
