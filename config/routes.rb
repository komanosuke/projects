Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # Session management
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      post 'admin_login', to: 'admin_sessions#create'
      delete 'admin_logout', to: 'admin_sessions#destroy'

      # Account activations and password resets
      resources :account_activations, only: [:edit]
      resources :password_resets, only: [:new, :create, :edit, :update]

      # User management
      resources :users, only: [:index, :show, :create, :update, :destroy] do
        resource :relationships, only: [:create, :destroy]
        get :follows, on: :member
        get :followers, on: :member
        collection do
          post :confirm
          get :back
          get :signup_done
          get :success
          get :current
        end
        member do
          get 'posts/posted', to: 'posts#posted'
          get 'posts/liked', to: 'posts#liked'
          get 'posts/commented', to: 'posts#commented'
        end
      end

      # Articles, News, Works, and their categories
      resources :works
      resources :work_cats
      resources :articles
      resources :article_cats
      resources :news
      resources :news_cats

      # Shopping cart for works
      resources :cart_works, only: [:create, :destroy, :index]
      post 'cart_works/sync', to: 'cart_works#sync'
      post 'cart_works/pay', to: 'cart_works#pay'

      # Admin views and actions
      post 'delete', to: 'main#delete'

      get 'html', to: 'doraemon#html'

      get 'cost', to: 'examples#cost'
      patch 'examples/update', to: 'examples#update'
      get 'media', to: 'examples#media'

      # Social media simulation
      resources :posts do
        resource :likes, only: [:create, :destroy]
        resources :comments, only: [:index, :create, :destroy]
      end

      # Studies and educational content
      resources :studies, only: [:index] do
        collection do
          get 'japanese'
          get 'math'
          get 'social'
          get 'science'
          get 'english'
          get 'kanji/:grade', action: 'kanji'
          post 'kanji_update'
          post 'collection_delete'
          get 'collection'
        end
      end

      # Contact form routes
      resource :contacts, only: [:create] do
        collection do
          get 'subject'
          get 'done'
        end
      end
    end
  end
end
