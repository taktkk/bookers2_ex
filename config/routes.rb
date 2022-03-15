Rails.application.routes.draw do
  
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  
  
  
  root to: "homes#top"
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'home/about' => 'homes#about' , as: 'about'
  
  get 'books' => 'books#index'
  get 'users' => 'users#index'
  
  
  # get 'books/new'
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'
  
  get 'books/:id/edit' => 'books#edit', as: 'edit_book'
  patch 'books/:id' => 'books#update', as: 'update_book'
  
  resources :books do
    
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    
  end
  
  
  
  resources :users
  
  
  # get 'users/:id' => 'users#show', as: 'user'
  # get 'users/:id/edit' => 'users#edit', as: 'edit_user'
  # patch 'users/:id' => 'users#update', as: 'update_user'
  
end
