Rails.application.routes.draw do
  # get('/posts/show', { to: 'posts#show' })
  resources :posts do
    resources :comments, only: [:create]
  end

  resources :users, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root 'posts#index'
end
