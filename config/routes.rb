Rails.application.routes.draw do

  resources :votes do
    resources :answers
  end

  resources :invites

  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    get "users/sign_up", to: "devise/registraions#new/:invite_token"
  end
end
