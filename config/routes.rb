Rails.application.routes.draw do
  
  devise_for :users
  root to: 'homes#top'
  resources :homes, onry:[:new]
  resources 'books'
  resources 'users'
    
end
