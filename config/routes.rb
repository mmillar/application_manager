ApplicationManager::Application.routes.draw do
  devise_for :users
  
  resources :profiles, :except => [:index, :destroy]

  match "application", :to => "profiles#new"

  match "faq", :to => "pages#faq"
  match "terms", :to => "pages#terms"
  match "apply", :to => "pages#apply_front"

  root :to => "pages#welcome"
  
  match "/admin", :to => "admin/profiles#index"
  namespace :admin do
    resources :profiles
    resources :reviews, :only => [:update]
  end
end
