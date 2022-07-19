class UsersController < ApplicationController
  #before_action :authorize, except: [:new, :create]

  def index
    user_id = params[:user_id]
    begin
      user = User.find(user_id)
      user.password_digest = "filtered"
      render json: user
    rescue => e
      head :not_found
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      render json: {"id": @user.id}, status: :created
    else
      render json: @user.errors.messages, status: :bad_request
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
