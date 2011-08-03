ApplicationManager::Application.routes.draw do
  devise_for :users
  
  resources :profiles

  match "application", :to => "profiles#new"

  match "faq", :to => "pages#faq"
  match "terms", :to => "pages#terms"

  root :to => "pages#welcome"
  
  namespace :admin do
    resources :profiles, :only => [:new, :index, :edit, :destroy]
  end
end
