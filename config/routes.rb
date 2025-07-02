Rails.application.routes.draw do

  root to: 'application#index'
  get "up" => "rails/health#show", as: :rails_health_check

end
