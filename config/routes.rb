Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
 
  get "/book", to: 'book#index', as:  :book
  post "/book", to: 'book#create', as: :create_book
  get '/profile', to: 'profile#show', as: :profile
  post '/equipment', to: 'profile#equipment_request', as: :equipment
  post '/vacation', to: 'vacation#vacation_request', as: :vacation
  post '/sick_leave', to: 'sick_leave#request_sick_leave', as: :sick_leave
  get '/manager_page', to: 'manager#index', as: :manager_page
  post '/export_doc', to: 'manager#export_doc', as: :export_doc
  post '/report', to: 'profile#report', as: :report

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end 

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  mount HrApp::V1::API => '/'

  post "/graphql", to: "graphql#execute"
end
