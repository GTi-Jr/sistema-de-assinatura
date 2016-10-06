Rails.application.routes.draw do
  namespace :plans do
    get 'payments/checkout'
  end

  root 'welcome#home'

  post 'contact_email' => 'welcome#contact_mail', as: :contact_form

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

  resources :addresses, only: [:destroy]

  # Rotas do perfil / profile routes
  get 'perfil' => 'users#profile', as: :user_profile
  patch 'update_user' => 'users#update', as: :update_user
  
  patch 'update_addresses' => 'users#update_addresses', as: :update_user_addresses
  post 'create_user_address' => 'users#add_address', as: :create_user_address
  patch 'update_main_address/:address_id' => 'users#update_main_address', as: :update_main_address

  patch 'update_babies' => 'users#update_babies', as: :update_user_babies
  post 'create_user_baby' => 'users#add_baby', as: :create_user_baby

  # Rotas dos planos
  resources :plans, only: [:show]
  get 'planos' => 'plans#index', as: :plans
  patch 'subscribe/:id' => 'plans#subscribe', as: :subscribe
  patch 'unsubscribe' => 'plans#unsubscribe', as: :unsubscribe
  patch 'plan_intention/:plan_id' => 'plans#intention_to_plan', as: :intention_to_plan

  # Checkout dos planos
  get 'aprovar-escolha/:id' => 'plans/payments#checkout', as: :plans_payment_checkout
  get 'proceder-para-paypal/:id' => 'plans/payments#paypal_checkout', as: :plans_paypal_checkout
  get 'confirmar/:id' => 'plans/payments#confirm', as: :plans_paypal_confirm
  post 'confirmar' => 'plans/payments#confirm_payment', as: :plans_paypal_confirm_payment

  resources :users do
    resources :babies
  end
end
