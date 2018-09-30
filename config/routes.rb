Rails.application.routes.draw do  
  scope path: 'admin' do
    authenticate :user, lambda { |u| u.admin? } do
      mount RailsEmailPreview::Engine, at: 'emails'
    end
  end
  
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:index, :show]
  mount Thredded::Engine => '/'
end
