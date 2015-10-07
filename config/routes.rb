Rails.application.routes.draw do
  scope '/v1' do
    resources :categories, only: [:index, :show]
    resources :resources, only: [:index, :show]
    resources :ratings, only: [:index, :create, :show, :destroy, :update]
    resources :rating_options, only: [:index]
  end

  match '*path', to: 'application#routing_error', via: :all
end
