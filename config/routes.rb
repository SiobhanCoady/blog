Rails.application.routes.draw do
  get('/posts/show', { to: 'posts#show' })
  root 'posts#index'
end
