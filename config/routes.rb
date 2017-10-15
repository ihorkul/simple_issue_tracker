Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'issues#new'

  get '/issues/:key/edit', to: 'issues#edit', as: :edit_issue
  resources :issues, only: [:index, :new, :create, :update, :show]
  resources :comments, only: [:create]
end
