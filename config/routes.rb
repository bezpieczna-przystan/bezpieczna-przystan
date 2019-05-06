# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :user, skip: :all
  devise_scope :user do
    get 'admin', to: 'devise/sessions#new'
    post 'admin', to: 'devise/sessions#create'
  end
  resources :animals do
    get 'adopt', to: 'adoptions#new', as: 'adoption'
    post 'adopt', to: 'adoptions#create', as: 'send_adoption_form'
    put :update_photo, on: :member

  end

  resources :articles do
    put :update_photo, on: :member
  end
  root 'articles#index'
  get 'contact-me', to: 'messages#new', as: 'new_message'
  post 'contact-me', to: 'messages#create', as: 'create_message'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
