Rails.application.routes.draw do
  resources :categories
  resources :resources do
    collection do
      get :search
    end
  end
end
