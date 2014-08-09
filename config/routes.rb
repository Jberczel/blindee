Rails.application.routes.draw do

  resources :votes do
    resources :answers
  end

  resources :invites

  devise_for :users
end
