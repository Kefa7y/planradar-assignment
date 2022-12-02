# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tickets
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  defaults format: :json do
    # TODO: place routes
  end
end
