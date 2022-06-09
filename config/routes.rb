Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :instructors, only: [:show, :index, :update, :destroy, :create] do
    resources :students, only: [:show, :index, :create, :update, :destroy]
  end

  resources :students, only: [:show, :index, :create, :update, :destroy]
end
