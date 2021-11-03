Rails.application.routes.draw do
  get 'home/about' => "homes#about"
  get 'users/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
devise_for :users
root to: 'homes#top', trailing_slash: true
resources :books, only: [:create, :index, :show, :destroy, :edit, :update,]
resources :users, only: [:create, :index, :show, :destroy, :edit, :update,]

end
