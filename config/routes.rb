Rails.application.routes.draw do
  get 'book_issues/new'
  devise_for :users
  get 'books_management/index'
  root 'main#index'

  resources :memberships, only: [:new, :create, :show]
  
  resources :memberships do
    member do
      get 'renew'
      post 'renewal_process'
    end
    collection do
      get 'search'
    end
  end

  
  resources :materials
end
