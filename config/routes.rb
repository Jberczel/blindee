Rails.application.routes.draw do
  resources :votes do
    member do
      get  :invite, to: 'invites#new_many'
      post :invite, to: 'invites#create_many'

      get  :notification, to: 'votes#new_notification'
      post :notification, to: 'votes#send_notification'
    end
    resources :answers
  end

  devise_for :users, :controllers => { :registrations => "registrations" }, :skip => [:sessions]
  as :user do
    get 'login'      => 'devise/sessions#new',     :as => :new_user_session
    post 'login'     => 'devise/sessions#create',  :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  root  'static_pages#home'
end

