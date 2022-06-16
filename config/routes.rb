Rails.application.routes.draw do

  # devise管理者側
  devise_for :admin, skip: [:registrations, :passwords],controllers: {
    sessions: "admin/sessions"
  }
  # devise会員側
  devise_for :members, skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者側
  namespace :admin do
    root :to => "homes#top"
    get 'members/:id/posts' => "members#posts"
    resources :members, only:[:show, :edit, :update]
    resources :posts, only:[:index, :show, :update, :edit, :destroy] do
      resources :comments, only:[:destroy]
    end
    resources :genres, only:[:index, :create, :edit, :update, :destroy]
    resources :comments, only:[:index]
  end

  # 会員側
  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    get 'members/my_page' => "members#my_page"
    get 'members/unsubscribe' => "members#unsubscribe"
    patch 'members/withdraw' => "members#withdraw"
    get 'members/:id/posts' => "members#posts", as: :members_posts
    get 'posts/post_management' => "posts#post_management"
    get 'searches/search' => "searches#search"
    resources :posts, only:[:new, :create, :edit, :update, :index, :destroy] do
      resources :comments, only:[:create, :destroy]
      resource :favorites, only:[:create, :destroy]
    end
    resources :members, only:[:edit, :update, :show] do
      resources :posts, only:[:show]
      resources :favorites, only:[:index]
    end
    resources :tags, only:[] do
      get 'tag_search' => "posts#tag_search"
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
