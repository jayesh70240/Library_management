Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 
  resources :books

  resources :book_issues, only: [:new, :create, :show]
  resources :book_issues do
    get 'checked_out_items', on: :collection
    member do 
      get "return"
    end
  end

  devise_for :users
    as :user do
      delete "/sign_out", to: "devise/sessions#destroy"
    end
    
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
