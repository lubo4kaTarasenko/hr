class VacationController < ApplicationController  
 
  def vacation_request   
    result = AllowVacation.call(user: current_user, start: params[:start].to_date, days: params[:days].to_i)
  
    return redirect_to(profile_path, notice: "Failed. Please speak to your manager") if result.failure?
    redirect_to(profile_path, notice: "Success") 
  end
end
