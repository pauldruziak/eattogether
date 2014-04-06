Eattogether::Application.routes.draw do
  resources :events, only: %w[index new create show]
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'events#index'
end
