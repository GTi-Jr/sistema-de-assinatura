Rails.application.routes.draw do
  root 'welcome#home'

  namespace :plans do
    get 'payments/checkout'
  end

  get '/checkout' => 'checkouts#checkout', as: :checkout
  post 'subscribe' => 'checkouts#subscribe_to_plan', as: :subscribe_to_plan
  post '/pay' => 'checkouts#pay', as: :payment
  post '/iugu_subscription' => 'plans#iugu_subscribe', as: :subscribe_iugu

  resources :users, only: [:new, :create]

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

  # Rotas do Devise
  devise_scope :user do
    get '/completar-cadastro' => 'users/registrations#after_registration', as: :after_registration
    patch '/completar-cadastro' => 'users/registrations#complete_registration', as: :complete_registration
    get '/entrar' => 'users/sessions#new', as: :login
    delete '/logout' => 'users/sessions#destroy', as: :logout
    get '/cadastro' => 'users/registrations#new'
  end

  resources :addresses, only: [:destroy]

  # Rotas do perfil / profile routes
  get 'perfil' => 'profile#profile', as: :user_profile
  patch 'update_user' => 'profile#update', as: :update_user

  patch 'update_addresses' => 'profile#update_addresses', as: :update_user_addresses
  post 'create_user_address' => 'profile#add_address', as: :create_user_address
  patch 'update_main_address/:address_id' => 'profile#update_main_address', as: :update_main_address

  patch 'update_subscription_babies/:subscription_id' => 'profile#update_subscription_babies', as: :update_subscription_babies

  # Rotas dos planos / plan routes
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

  get 'politica-de-privacidade' => 'files#privacy_terms', as: :privacy_terms
end
