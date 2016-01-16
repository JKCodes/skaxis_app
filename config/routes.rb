Rails.application.routes.draw do
  root 'main_pages#home'
  get 'help'    => 'main_pages#help'
  get 'about'   => 'main_pages#about'
  get 'contact' => 'main_pages#contact'
  get 'terms'   => 'main_pages#terms'
  get 'privacy' => 'main_pages#privacy'
  get 'signup'  => 'users#new'
  resources :users
end
