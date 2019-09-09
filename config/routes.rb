Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root to: "tasks#active"
  get 'tasks/completed', to: 'tasks#completed'
  get 'tasks/active', to: 'tasks#active'

  resources :tasks do
    member do
      put 'complete'
      get 'access_denied'
    end

    collection do
      delete 'destroy_multiple'
    end
  end
  # match 'tasks/:id/complete' => "complete_task#complete", :via => :put
end
