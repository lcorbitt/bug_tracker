class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, only: :update

  protected

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if params["password"]&.present?

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password"))
  end
end
