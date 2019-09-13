Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tasks do
    member do
      put 'complete'
      get 'access_denied'
    end

    collection do
      delete 'destroy_multiple'
    end
  end
  get '', to: redirect('/tasks')
end
