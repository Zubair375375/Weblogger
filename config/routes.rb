Rails.application.routes.draw do
  devise_for :users

  resources :users do
    member do
      delete :cover_image
      post "intro_video", to: "users#create_intro_video"
      get "intro_video", to: "users#intro_video"
    end
  end

  authenticate :user do
    root "articles#index"
    get "home", to: "articles#home"

    resources :users do
          # resources :intro_videos do
          resources :user_comments, only: [ :create, :destroy, :show ] do
            post "reaction", to: "user_comments#reaction", as: :react_user_comment
            delete "reaction", to: "user_comments#unreacted", as: :unreact_user_comment
          end

          resources :profile_shares, only: [ :index, :destroy, :show ]
        end
        post "users/:id/profile_shares", to: "profile_shares#create", as: :profile_shares

    post "users/:id/follow", to: "users#follow", as: :follow_user
    delete "users/:id/unfollow", to: "users#unfollow", as: :unfollow_user


        # resources :users do
        resources :articles do
          resources :comments
        end
    # end
  end
end
