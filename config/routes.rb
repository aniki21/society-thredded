Rails.application.routes.draw do  
  # root to: redirect('/forum')
  scope path: 'admin' do
    authenticate :user, lambda { |u| u.admin? } do
      mount RailsEmailPreview::Engine, at: 'emails'
    end
  end
  
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show]

  resources :private_topics, only: [:new], controller: 'thredded/private_topics'
  mount Thredded::Engine => '/'
end
