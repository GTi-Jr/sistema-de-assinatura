Rails.application.routes.draw do
  root 'welcome#home'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
    confirmations: 'admins/confirmations',
    unlocks: 'admins/unlocks'
  }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
 
  #Rotas do Devise
  devise_scope :user do
    get '/completar-cadastro' => 'users/registrations#after_registration', as: :after_registration
    patch '/completar-cadastro' => 'users/registrations#complete_registration', as: :complete_registration
    get '/entrar' => 'users/sessions#new', as: :login
    delete '/logout' => 'users/sessions#destroy', as: :logout
    get '/cadastro' => 'users/registrations#new'
  end

  # Rotas do perfil / profile routes
  get 'perfil' => 'users#profile', as: :user_profile
  patch 'update_user' => 'users#update', as: :update_user
  patch 'update_addresses' => 'users#update_addresses', as: :update_user_addresses
  post 'create_user_address' => 'users#add_address', as: :create_user_address

  resources :users do
    resources :babies
  end
end
