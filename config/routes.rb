ApplicationManager::Application.routes.draw do
  devise_for :users

  resources :profiles

  root :to => "profiles#new"
  
  namespace :admin do
    resources :profiles, :only => [:new, :index, :edit, :destroy]
  end
end
