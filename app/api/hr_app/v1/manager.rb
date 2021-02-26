class HrApp::V1::Manager < Grape::API

  namespace :manager do
    desc 'show all users to manager'
    get ':token' do
      authorize! :book, current_user
      result = ShowAllUserInfo.call(user_collection: User.full_info)
      expose_result(result, result.users, HrApp::V1::Entities::Manager)
    end
    
    desc 'export users infos to google doc'
    params do     
      optional :name
      optional :level
      optional :skills
      optional :english_level
      optional :email
      optional :hours
      optional :vacations
      optional :sick_leaves
      optional :time_slots
    end
    post '/export_doc/:token' do
      authorize! :book, current_user
      result = ExportToGoogleDoc.call(user_collection: User.full_info, params: params.keys)
      expose_result(result, result, HrApp::V1::Entities::Link)
    end

    desc 'book user on a project'
    params do     
      requires :user, type: String, allow_blank: false
      requires :time, type: Integer, allow_blank: false
      requires :start, type: Date, allow_blank: false
      requires :finish, type: Date, allow_blank: false 
      requires :project, type: String, allow_blank: false 
      requires :status, type: String, allow_blank: false 
    end
    post '/book/:token' do
      authorize! :book, current_user
      result = BookUser.call(params: params)
      expose_result(result, {message: 'Success'}, HrApp::V1::Entities::Message)
    end
  end
end
