class Api::V1::UsersController < Api::V1::ApiController
  before_action :require_login, except: [:show]
  skip_before_action :authenticate_request, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_error

  def show
    render json: { user: User.find(params[:id]) }
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: { user: @user }
    else
      render json: { errors: @user.errors }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
    end

    def not_found_error
      render json: { errors: [{ details: "User not found." }] }
    end
end
