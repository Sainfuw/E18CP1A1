class ApplicationController < ActionController::Base
  before_action :store_user

  # def owner
  #   if !(current_user.id == Product.find(params[:id]).user.id)
  #     redirect_to root_path, alert: 'No tiene autorizacion para esta accion.'
  #   end
  # end

  def authenticate_user?
    if !current_user.present?
      redirect_to new_user_registration_path, alert: 'Debe estar registrado para continuar.'
    end
  end
  private
  def store_user
    User.current = current_user
  end
end
