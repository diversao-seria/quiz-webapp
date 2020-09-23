class QuizzesController < ApplicationController
  before_action :authorize, except: [:find_by_code]

  def index
    @quizzes = Quiz.all
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)

    if @quiz.save
      redirect_to @quiz
    else
      render "new"
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
