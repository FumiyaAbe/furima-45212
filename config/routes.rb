Rails.application.routes.draw do
  devise_for :users

  root to: 'items#index'
  get "up" => "rails/health#show", as: :rails_health_check
  resources :items, only: [:index, :new, :create, :show, :edit, :update]#← , :destroyを後で追加
end
