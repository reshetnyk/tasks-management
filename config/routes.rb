Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tasks, except: [:new] do
    put 'complete', on: :member
    get 'access_denied', on: :member
    delete 'destroy_multiple', on: :collection
    get 'create', on: :collection, as: 'create'
    post 'create', on: :collection, as: 'post_create'
  end
  get '', to: redirect('/tasks')
end
