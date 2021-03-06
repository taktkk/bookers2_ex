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
    get "search", to: "users#search"
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
  get "search_book" => "books#search_book"
  
end
