Rails.application.routes.draw do
  # get('/posts/show', { to: 'posts#show' })
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update] do
    get :edit_password, on: :collection
    patch :update_password, on: :collection
    put :update_password, on: :collection
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root 'posts#index'
end
