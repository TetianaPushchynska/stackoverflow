# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registration: "registration", omniauth_callbacks: "omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :commentable do
    resources :comments
  end

  root "questions#index"
  resources :questions, concerns: :commentable, shallow: true do
    resources :answers, concerns: :commentable
  end
end
