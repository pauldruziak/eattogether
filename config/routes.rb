Eattogether::Application.routes.draw do
  resources :events, only: %w[index new create]
  devise_for :users
  root to: 'events#index'
end
