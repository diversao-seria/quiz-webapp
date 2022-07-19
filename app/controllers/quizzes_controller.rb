class QuizzesController < ApplicationController
  #before_action :authorize, except: [:find_by_code]

  def index
    user_id = params[:user_id]
    quizzes = Quiz.where(user_id: user_id)
    render json: quizzes
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.create(quiz_params)

    set_correct_alternatives

    if @quiz.save
      render json: @quiz, status: :created
    else
      render json: @quiz.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz = Quiz.find(params[:quiz_id])
    @quiz.destroy
    head :no_content
  end

  def find_by_code
    @quiz = Quiz.find_by(code: params["code"])

    render :json => @quiz
  end

  private

  def quiz_params
    params.require(:quiz).permit(
      :user_id,
      :title,
      :code,
      questions_attributes: [
        :title,
        :_destroy,
        alternatives_attributes: [
          :text,
          :correct
        ]
      ]
    )
  end

  def set_correct_alternatives
    @quiz.questions.each { |question| question.alternatives.first.correct = true }
  end
end
