Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'reset_password/new'

  get 'reset_password/edit'

  root 'main_pages#home'
  get 'help'      => 'main_pages#help'
  get 'about'     => 'main_pages#about'
  get 'contact'   => 'main_pages#contact'
  get 'terms'     => 'main_pages#terms'
  get 'privacy'   => 'main_pages#privacy'
  get 'signup'    => 'users#new'
  get 'login'     => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
