Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :tasks, except: [:new, :edit] do
    get 'create', on: :collection, as: 'create'
    delete 'destroy', on: :collection, as: 'destroy'
  end
  get '', to: redirect('/tasks')
  root to: 'tasks#index'
end
