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

    resources :order_items, only: [:show, :update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :show, :edit, :new, :create, :update]
    get 'top' => 'homes#top'

  end
  #customer用
  scope module: :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        get 'complete' => 'orders#complete'
      end
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete "destroy_all"
      end
    end
    post 'orders/confirm'
    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get  'customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch  'customers/withdraw' => 'customers#withdraw'
    resources :items, only: [:index, :show]
    resources :genres, only: [:show]
    get 'homes/about' => 'homes#about'
    get 'search'=> 'searches#search'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
