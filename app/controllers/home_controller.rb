class HomeController < ApplicationController
  
  def index
    @users = User.order(id: :desc).includes(:personal_info, :skills).map do |user|
      result = ShowUser.call(user: user)
      result.attrs
    end
    @paginated_users = Kaminari.paginate_array(@users).page(params[:page]).per(ENV['USER_PER_PAGE'])
  end
end
