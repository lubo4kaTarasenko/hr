class ManagerController < ApplicationController
  
  def index    
    @paginated_users = Kaminari.paginate_array(users_scope).page(params[:page]).per(ENV['USER_PER_PAGE']) 
    result = ShowAllUserInfo.call(user_collection: @paginated_users)
    @users = result.users
  end

  def export_doc
    result = ExportToGoogleDoc.call(user_collection: User.full_info, params: permitted_params.keys)
    return redirect_to(manager_page_path , notice: 'Uploaded failed') if result.failure?
    @link = result.link
  end

  private

  def permitted_params
    params.require(:csv).permit(:name, :email, :level, :english_level, :hours, :time_slots, :skills, :vacations, :sick_leaves)
  end
end
