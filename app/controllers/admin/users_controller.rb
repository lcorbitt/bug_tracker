class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :toggle_role]
  before_action :is_admin?, only: [:index, :toggle_role]

  def index
    @users = User.all.sort
    @paginated_users = @users.paginate(page: page, per_page: 10)
  end

  def toggle_role
    user = User.find(params[:id])

    respond_to do |format|
      if params[:role] == "admin"
        user.update_attribute(:role, :admin)
        format.html { redirect_to admin_users_path, notice: "👑 #{user.username} is now an Admin!" }
      else
        user.update_attribute(:role, :employee)
        format.html { redirect_to admin_users_path, notice: "🙊 #{user.username} is no longer an Admin..." }
      end
    end
  end

  private

  def is_admin?
    if current_user.employee?
      redirect_to dashboard_index_path, alert: "You are not authorized to view that page."
    end
  end

  def page
    params[:page]
  end
end
