Eattogether::Application.routes.draw do
  resources :events, only: %w[index new create show edit update] do
    resources :transactions, shallow: true
    resources :families, shallow: true, only: %w[index new create destroy]
  end

  devise_for :users, controllers: { registrations: 'users/registrations', invitations: 'users/invitations' }
  root to: 'events#index'
end
