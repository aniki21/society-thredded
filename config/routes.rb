Rails.application.routes.draw do
  scope path: 'admin' do
    authenticate :user, lambda { |u| u.admin? } do
      mount RailsEmailPreview::Engine, at: 'emails'
    end
  end

  devise_for :users,
             skip: %i[sessions],
             controllers: {
                 registrations: 'users/registrations',
                 sessions: 'users/sessions',
             },
             path_names: { sign_up: 'register' }
  devise_scope :user do
    get 'sign-in', to: 'users/sessions#new', as: :new_user_session
    post 'sign-in', to: 'users/sessions#create', as: :user_session
    match 'sign-out', to: 'users/sessions#destroy', as: :destroy_user_session,
          via: Devise.mappings[:user].sign_out_via
  end

  resources :users, only: [:index, :show]

  resources :private_topics, only: [:new], controller: 'thredded/private_topics'

  scope module: 'thredded_ext', as: :thredded_ext, path: 'thredded-ext' do
    scope module: 'moderation', as: :moderation, path: 'moderation' do
      resources :users, only: %i[update]
    end
  end

  mount Thredded::Engine => '/'
end
