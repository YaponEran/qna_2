Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "questions#index"

  concern :votable do
    member do
      patch :vote_up
      patch :vote_down
      delete :vote_reset
    end
  end

  resources :questions, concerns: :votable do
    resources :answers, concerns: :votable, shallow: true do
      patch :choose_best, on: :member
    end
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy

  resources :awards, only: :index

  mount ActionCable.server => '/cable'
end
