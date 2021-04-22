class QuizzesController < ApplicationController
  before_action :authorize, except: [:find_by_code]

  def index
    @quizzes = Quiz.where(user_id: @current_user)
  end

  def show
    begin
      @quiz = Quiz.find(params[:id])

      if @quiz.user_id != @current_user.id
        redirect_to '/quizzes'
      end
    rescue => e
      redirect_to '/quizzes'
    end
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)

    if @quiz.save
      redirect_to @quiz
    else
      render 'new'
    end
  end

  def find_by_code
    @quiz = Quiz.find_by(code: params["code"])

    render :json => @quiz
  end

  def quiz_params
    params.require(:quiz).permit(
      :user_id,
      :title,
      :code,
      :questions
    )
  end
end
