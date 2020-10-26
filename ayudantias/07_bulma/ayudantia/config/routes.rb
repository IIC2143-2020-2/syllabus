# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/users/delete' => 'devise/registrations#destroy'
  end
  resources :articles
  resources :categories
  resources :meals
  root 'welcome#index'
end
