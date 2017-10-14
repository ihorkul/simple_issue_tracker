Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'issues#new'

  resources :issues, only: [:index, :new, :create, :update] do
    # member { post :update_status }
  end
end
