class BookController < ApplicationController
  
  def index
    @projects = Project.all.pluck(:name)
  end

  def create
    authorize! :book, current_user 
    result = BookUser.call(params: params)
    return failed_booking if result.failure?
    
    redirect_to(root_path , notice: 'success') 
  end  

  private

  def failed_booking
    redirect_to(book_path(user_id: params[:user]), notice: "Booking fields are invalid")
  end
end
