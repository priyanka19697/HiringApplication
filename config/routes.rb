Rails.application.routes.draw do
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :interviews
  resources :applications
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'manager', to: 'manager#index', as:'manager'
  get 'interviewer', to: 'interviewer#index', as:"interviewer"
  get '/applications/:id/relese_offer_letter', to: 'applications#release_offer', as: :release_offer_letter
  root to: "login#show"
  resources :applications do
    resources :interviews
  end
  get '/openapplications', to: 'applications#open_applications', as: "open_applications"
  get '/inprogressapplications', to: 'applications#inprogress_applications', as: "inprogress_applications"
  get '/acceptedapplications', to: 'applications#accepted_applications', as: "accepted_applications"
  get '/rejectedapplications', to: 'applications#rejected_applications', as: "rejected_applications"

  get '/users/:id/scheduled_interviews', to: 'interviews#scheduled_interviews', as: "scheduled_interviews"
  get '/users/:id/completed_interviews', to: 'interviews#completed_interviews', as: "completed_interviews"
  get '/users/:id/assigned_interviews', to: 'interviews#assigned_interviews', as: "assigned_interviews"
  get '/feedback/:id', to: 'applications#show_feedback_page', as: "show_feedback"
  patch '/feedback/:id', to: 'applications#give_feedback_page', as: "give_feedback"
  get '/thankyou', to: 'applications#thankyou', as: "thankyou"
  get '/reject/:id', to: 'applications#reject_offer', as:"reject_offer"
  get '/accept/:id', to: 'applications#accept_offer', as:"accept_offer"
  patch '/response/:id', to: 'applications#response', as: "give_response"



end
