Rails.application.routes.draw do



  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Facebook::Messenger::Server, at: 'bot'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  resources :user_page, only: [:create]
  resources :page_bots, only: [:show, :index] do
    resources :bot_events
  end
  resources :page_bot_configurations, only: [:show, :update, :destroy]

end
