class Api::V1::UsersController < ApplicationController
  before_action :require_login, except: [:show]

  def show
    #@user = User.find(params[:id])
    render json: User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: { user: @user }
    else
      render json: @user.errors
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
    end
end
