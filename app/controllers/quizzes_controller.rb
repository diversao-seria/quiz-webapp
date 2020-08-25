class QuizzesController < ApplicationController
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

  def quiz_params
    params.require(:quiz).permit(
      :user_id,
      :title,
      :code,
      :questions
    )
  end
end
