class HrApp::V1::Profile < Grape::API

  namespace :profile do
    desc 'get user info by id'
    params do
      requires :id, type: String, allow_blank: false
    end
    get ':token' do   
      result = ShowUser.call(user: current_user)
      expose_result(result, result.attrs, HrApp::V1::Entities::User)
    end

    desc 'equipment request by user'
    params do
      requires :message, type: String, allow_blank: false
    end
    post '/equipment/:token' do
      result = SendEmail.call(message: params[:message], user: current_user)
      expose_result(result, {message: 'we have sent email to devops'}, HrApp::V1::Entities::Message)
    end

    desc 'take sick leaves'
    params do
      requires :start_sick, type: Date, allow_blank: false
      requires :sick_days, type: Float, allow_blank: false
    end
    post '/sick_leaves/:token' do
      result = ReserveSickLeave.call(user: current_user, start: params[:start_sick], days: params[:sick_days])
      expose_result(result, {message: 'success'}, HrApp::V1::Entities::Message)
    end

    desc 'take vacations'
    params do
      requires :start, type: Date, allow_blank: false
      requires :days, type: Integer, allow_blank: false
    end
    post '/vacations/:token' do
      result = AllowVacation.call(user: current_user, start: params[:start], days: params[:days])
      expose_result(result, {message: 'success'}, HrApp::V1::Entities::Message)
    end
  end
end
