class ProfileController < ApplicationController
  
  def show
    result = ShowUser.call(user: current_user)

    return redirect_to(root_path , notice: 'cannot show user') if result.failure?
    @user = result.attrs    
  end

  def equipment_request   
    SendEmail.call(message: params[:message], user: current_user)
    redirect_to profile_path
  end 
  
  def report
    result = ShowUserReport.call(user: current_user, date: params[:date].to_date)
    return redirect_to(profile_path, notice: result.message) if result.failure? 

    @report = result.report
    respond_to do |format|
      format.js { render action: :report, layout: nil }
    end
  end
end
