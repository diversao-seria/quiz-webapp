class UsersController < ApplicationController
  #before_action :authorize, except: [:new, :create]

  def index
    redirect_to '/quizzes'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to '/quizzes'
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
