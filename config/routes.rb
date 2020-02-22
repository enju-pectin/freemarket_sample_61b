Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'user_regist', to: 'users/registrations#step1'
    post 'user_regist', to: 'users/registrations#step1_regist'
    get 'phone_regist', to: 'users/registrations#step2'
    post 'phone_regist', to: 'users/registrations#step2_regist'
    get 'phone_confirm', to: 'users/registrations#phone_confirm'
    post 'phone_confirm', to: 'users/registrations#phone_confirm_input'
    get 'destination_regist', to: 'users/registrations#step3'
    post 'destination_regist', to: 'users/registrations#step3_regist'
    get 'creditcard_regist', to: 'users/registrations#step4'
    post 'creditcard_regist', to: 'users/registrations#step4_regist'
  end
  # ビューの動作テスト用の仮のルーティング
  #  get 'registrations/1', to: 'users/registrations#step1'
  #  get 'registrations/2', to: 'users/registrations#step2'
  #  get 'registrations/3', to: 'users/registrations#step3'
  #  get 'registrations/4', to: 'users/registrations#step4'
  #  post 'registrations/5', to: 'users/registrations#create'
  # end
  root to: "home#top"
  resources :products, only: :new
  get 'home/top'
  resources :users, only: [:show, :edit] do
    resources :credit_cards, only: [:show]
  end
  resources :home, only: [:show]
end
