Rails.application.routes.draw do
  scope '/v1' do
    resources :categories, only: [:index, :show]
    resources :resources, only: [:index, :show]
  end

  match "*path", :to => "application#routing_error", :via => :all
end
