Rails.application.routes.draw do
  
  root to: "homes#top"
  devise_for :users
  get 'home/about' => 'homes#about' , as: 'about'
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  
  
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end
  
end
