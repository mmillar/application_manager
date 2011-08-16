ApplicationManager::Application.routes.draw do
  devise_for :users
  
  resources :profiles

  match "application", :to => "profiles#new"

  match "faq", :to => "pages#faq"
  match "terms", :to => "pages#terms"
  match "apply", :to => "pages#apply_front"

  root :to => "pages#welcome"
  
  match "/admin", :to => "admin/profiles#index"
  match "/admin/export", :to => "admin/exports#get_workbook"

  namespace :admin do
    resources :profiles
    resources :reviews, :only => [:update]
  end
end
