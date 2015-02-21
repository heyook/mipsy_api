Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'home#index'

  # https://github.com/gonzalo-bulnes/simple_token_authentication/issues/42
  devise_for :users, skip: [:sessions, :registrations, :passwords, :confirmations]

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      devise_for :users,
        controllers: {
          sessions:  'api/v1/users/sessions',
          registrations: 'api/v1/users/registrations',
          passwords: 'api/v1/users/passwords',
          confirmations: 'api/v1/users/confirmations'
        }

      namespace :users do
        resources :oauths, only: [:create]
        resource :account
      end
    end
  end

end
