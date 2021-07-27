class MatchesController < ApplicationController

  def index
    @id = params[:quiz]
    if @id == nil or @id == ""
      return redirect_to(root_url)
    end
    begin
      quiz = Quiz.find(@id)
      # comente esse if caso queira fazer testes em vários quizzes
      if quiz.user_id != @current_user.id
        redirect_to '/quizzes'
      end

      @quiz_title = quiz.title
      @matches = Match.where(quiz_id: @id)
      @questions = helpers.select_questions(@id, @matches)
      @general_data = helpers.select_general_data(@matches)
    rescue => e
      redirect_to '/quizzes'
    end
  end

  def create
    @match = Match.create(match_params)
    if @match.save
      render json: @match, status: :created
    else
      render json: @match.errors.messages, status: :unprocessable_entity
    end
  end

  def match_params
    params.require(:match).permit(:quiz_id, :start_time, results: {})
  end

end
