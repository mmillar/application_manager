ApplicationManager::Application.routes.draw do
  resources :profiles
  root :to => "profiles#new"
end
