Rails.application.routes.draw do
  scope path: 'admin' do
    authenticate :user, lambda { |u| u.admin? } do
      mount RailsEmailPreview::Engine, at: 'emails'
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:index, :show]

  resources :private_topics, only: [:new], controller: 'thredded/private_topics'

  scope module: 'thredded_ext', as: :thredded_ext, path: 'thredded-ext' do
    scope module: 'moderation', as: :moderation, path: 'moderation' do
      resources :users, only: %i[update]
    end
  end

  mount Thredded::Engine => '/'
end
