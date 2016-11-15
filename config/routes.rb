Rails.application.routes.draw do
  root 'welcome#home'

  namespace :plans do
    get 'payments/checkout'
  end
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
    get '/cadastro' => 'users/registrations#new', as: :register
  end

  # iugu checkout payment pagamento
  post '/iugu_checkout/:plan_identifier' => 'iugu/checkouts#checkout', as: :iugu_checkout
  get '/finalizar-compra/:plan_identifier' => 'checkouts#checkout', as: :checkout
  post 'iugu/pay' => 'checkouts#pay', as: :payment
  put '/iugu_suspend/:id' => 'iugu/checkouts#suspend', as: :iugu_suspend
  post 'iugu/webhooks' => 'iugu/webhooks#webhook', as: :iugu_wekhooks
  post '/iugu_subscription' => 'plans#iugu_subscribe', as: :subscribe_iugu
  delete 'iugu_unsubscribe/:id' => 'plans#unsubscribe', as: :iugu_unsubscribe
  get 'aprovar-escolha/:plan_identifier' => 'plans/payments#confirm_checkout', as: :confirm_checkout

  # Subscriptions / Assinaturas
  get 'confirmar-cancelamento/:id' => 'subscriptions#confirm_cancellation', as: :confirm_cancellation
  get 'assinaturas/:id/trocar-de-plano' => 'subscriptions#choose_plan', as: :choose_plan
  get 'assinaturas/:id/trocar-de-plano/:plan_identifier' => 'subscriptions#confirm_change_plan', as: :confirm_change_plan
  patch 'assinaturas/:id/trocar-de-plano/:plan_identifier' => 'subscriptions#change_plan', as: :change_plan

  # Rotas para endereços
  resources :addresses, only: [:create, :update,:destroy]

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
  patch 'unsubscribe/:subscription_id' => 'plans#unsubscribe', as: :unsubscribe
  patch 'plan_intention/:plan_id' => 'plans#intention_to_plan', as: :intention_to_plan

  get 'politica-de-privacidade' => 'files#privacy_terms', as: :privacy_terms
end
