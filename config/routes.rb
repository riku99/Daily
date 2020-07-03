Rails.application.routes.draw do
  root 'home#index'
  namespace :api do
    resources :lists, :diaries
  end
end
