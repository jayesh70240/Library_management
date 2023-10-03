class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def check_librarian_or_admin_role
    unless current_user.librarian? || current_user.admin?
      flash[:alert] = "You are not authorized to access this page. Your role is: #{current_user.role}"
      redirect_to root_path
    end
  end
end