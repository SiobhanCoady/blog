Rails.application.routes.draw do
  # get('/posts/show', { to: 'posts#show' })
  resources :posts, only: [:show, :create, :new] do
    resources :comments, only: [:create]
  end
  root 'posts#index'
end
