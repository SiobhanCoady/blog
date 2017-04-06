Rails.application.routes.draw do
  # get('/posts/show', { to: 'posts#show' })
  resources :posts, only: [:show]
  root 'posts#index'
end
