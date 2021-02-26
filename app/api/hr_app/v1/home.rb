class HrApp::V1::Home < Grape::API

  namespace :home do
    desc 'show users public infos'
    get do
      result = ShowAllUserInfo.call(user_collection: User.all)
      expose_result(result, result.users, HrApp::V1::Entities::User)
    end
  end
end
