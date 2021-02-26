class SickLeaveController < ApplicationController  
 
  def request_sick_leave
    result = ReserveSickLeave.call(user: current_user, start: params[:start_sick].to_date, days: params[:sick_days].to_f)
    return redirect_to(profile_path, notice: "Failed. Please speak to your manager") if result.failure?
    redirect_to(profile_path, notice: "Success") 
  end
end
