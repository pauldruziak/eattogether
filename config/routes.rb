Eattogether::Application.routes.draw do
  devise_for :users
  root to: 'events#index'
end
