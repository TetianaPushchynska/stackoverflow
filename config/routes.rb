# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { registration: "registration", omniauth_callbacks: "omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :commentable do
    resources :comments
  end

  resources :questions, concerns: :commentable, shallow: true do
    resources :answers, concerns: :commentable
  end

  namespace "api" do
    namespace "v1" do
      get "profiles/me", to: "/api/v1/profiles#me"
    end
  end

  root "questions#index"
end
