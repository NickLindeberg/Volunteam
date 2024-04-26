Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :volunteers
      resources :instruments
    end
  end
end
