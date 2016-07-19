Rails.application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions',
                            registrations: 'registrations'}
  resources :users
  resources :homes do
    resources :chores do
      post 'thumbs_up'
      member do
        put "like", to: "links#upvote"
        put "dislike", to: "links#downvote"
        get "votecount", to: "posts#votecount"
      end
    end
    resources :bills do
      post 'completed'
    end
    resources :lists do
      post 'completed'
    end
    resources :users, only: [:index]
  end
  # devise_scope :user do
  # root :to => 'devise/sessions#new'
# end

end
