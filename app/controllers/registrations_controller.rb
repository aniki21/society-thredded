class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

  private
  def check_captcha
    return if Rails.env.development?
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides Recaptcha
      set_minimum_password_length
      respond_with resource
    end 
  end

  def account_update_params
    params.require(:user).permit(:display_name, :bio, :email, :password, :password_confirmation, :current_password, :steam, :switch, :psn, :xbox)
  end
end
