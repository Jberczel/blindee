Rails.application.routes.draw do

  resources :votes do
    resources :answers
  end

  devise_for :users
end
