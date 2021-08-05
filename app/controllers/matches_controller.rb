class MatchesController < ApplicationController

  def index
    @id = params[:quiz]
    return redirect_to(root_url) if @id.blank?

    begin
      quiz = Quiz.find(@id)
      #redirect_to '/quizzes' if quiz.user_id != @current_user.id
      @quiz_title = quiz.title
      @matches = Match.where(quiz_id: @id)
      @questions = helpers.select_questions(@id, @matches)
      @general_data = helpers.select_general_data(@matches)
      @general_graph_data = {"Acertos" => @general_data['correct_answers'], "Erros" => @general_data['wrong_answers']}
      @questions_graph_data = {"Questões respondidas" => @general_data['total_answers'], "Questões não respondidas" => @general_data['total_questions'] - @general_data['total_answers']}
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
