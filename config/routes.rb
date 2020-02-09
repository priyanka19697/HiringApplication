Rails.application.routes.draw do
  resources :interviews
  resources :applications
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'manager', to: 'manager#index', as:'manager'
  get 'interviewer', to: 'interviewer#index', as:"interviewer"
  # get 'manager', to: 'manager#show'
  get '/applications/:id/relese_offer_letter', to: 'applications#release_offer', as: :release_offer_letter
  root to: "login#show"
  resources :applications do
    resources :interviews
  end

  get '/users/:id/scheduled_interviews', to: 'interviews#scheduled_interviews', as: "scheduled_interviews"
  get '/users/:id/assigned_interviews', to: 'interviews#assigned_interviews', as: "assigned_interviews"
  patch 'users/:user_id/assigned_interviews/:id/accept', to: 'interviews#accept_interview', as: "accept_interview"
  patch 'users/:user_id/assigned_interviews/:id/decline', to: 'interviews#decline_interview', as: "decline_interview"

end
