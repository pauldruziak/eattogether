class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
    UserMailer.welcome_email(resource).deliver
  end
end
