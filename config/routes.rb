Rails.application.routes.draw do
  #customer用認証機能
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  #admin用認証機能
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  #ルートパス
  root to:'public/homes#top'
  #admin用
  namespace :admin do
    get 'order_item' => 'order_items#show'
    get 'orders' => 'orders#show'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :show, :edit, :new, :create, :update]
    get 'top' => 'homes#top'
  end
  #customer用
  scope module: :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :index, :show, :create]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    get 'orders/complete'
    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get  'customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch  'customers/withdraw' => 'customers#withdraw'
    resources :items, only: [:index, :show]
    get 'homes/about' => 'homes#about'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
