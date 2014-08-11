Rails.application.routes.draw do

  resources :votes do
    resources :answers
  end

  resources :invites

  devise_for :users, :controllers => { :registrations => "registrations" }


  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  root  'static_pages#home'
end
