class HrApp::V1::API < Grape::API
  format :json
  prefix :api
  version :v1
  resource :users

  rescue_from ::CanCan::AccessDenied do
    error!('403 Forbidden', 403)
  end

  rescue_from Mongoid::Errors::DocumentNotFound  do
    error!('403 Invalid query', 403)
  end
  
  helpers do
    def current_user
      User.find_by(token: params[:token])
    end    

    def expose_result(interactor_result, data, entity_klass)
      return { error: interactor_result.message } if interactor_result.failure?
      
      present data, with: entity_klass
    end  
  end

  mount HrApp::V1::Home
  mount HrApp::V1::Manager
  mount HrApp::V1::Profile
end
