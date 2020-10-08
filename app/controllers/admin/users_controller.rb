class Admin::UsersController < ApplicationController
  def index
    @users = User.all.sort
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
end
