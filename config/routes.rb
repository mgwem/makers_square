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
    get 'posts/member_posts' => "posts#member_posts"
    resources :members, only:[:show, :edit, :update]
    resources :posts, only:[:index, :show, :update, :edit, :destroy]
    resources :genres, only:[:index, :create, :edit, :update, :destroy]
  end

  # 会員側
  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    get 'members/my_page' => "members#my_page"
    get 'members/unsubscribe' => "members#unsubscribe"
    patch 'members/withdraw' => "members#withdraw"
    get 'posts/post_management' => "posts#post_management"
    get 'posts/member_posts' => "posts#member_posts"
    resources :members, only:[:edit, :update, :show] do
      resources :posts, only:[:show]
    end
    resources :posts, only:[:new, :create, :edit, :upadate, :index, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
