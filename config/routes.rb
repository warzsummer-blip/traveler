Rails.application.routes.draw do
  devise_for :users

  # トップページ
  root to: "homes#top"

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # 投稿機能（コメント・いいね・確認画面を1つにまとめる）
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    
    collection do
      get :confirm # POST送信にしたい場合は get から post に変更してください
    end
  end

  # ユーザー機能（フォロー・フォロワー・関係性を1つにまとめる）
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end
end