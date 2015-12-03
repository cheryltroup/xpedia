Rails.application.routes.draw do

  resources :wikis do
  	resources :collaborators
  end
  resources :charges, only: [:new, :create]
  devise_for :users
  resources :users, only: [:update]

  get 'about' => 'welcome#about'
  get 'upgrade' => 'charges#new'
  get 'downgrade' => 'users#downgrade'
  get 'collaborator' => 'collaborators#index'

  root to: 'welcome#index'

end
