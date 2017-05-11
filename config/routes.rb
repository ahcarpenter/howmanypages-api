Rails.application.routes.draw do
  # resources :users, only: [:show] do
  #   resources :repositories, only: [:show]
  # end
  mount ActionCable.server => '/cable'

  match ':username/:repository', to: 'repositories#show', via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
