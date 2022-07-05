class MatchesController < ApplicationController

  def index
    @id = params[:quiz]
    @match_id = params[:match_id]
    unless @match_id.nil?
      render json: match_show(@match_id)
      return
    end
    quiz = Quiz.find(@id)
    matches = Match.where(quiz_id: @id)
    players_array = []
    cache_array = []
    matches.each do |match|
      if cache_array.include? match.player_id or match.player_id.blank?
        next
      end
      players_array.append({ "id" => match.player_id, "name" => Player.find(match.player_id).name})
      cache_array.append(match.player_id)
    end
    @arr = players_array
    render json: {
      "quiz_title": quiz.title,
      "matches": matches
    }
  end

  def create
    @match = Match.create(match_params)
    if @match.save
      render json: @match, status: :created
    else
      render json: @match.errors.messages, status: :unprocessable_entity
    end
  end

  def match_show(match_id)
    begin
      quiz = Quiz.find(match_id)
      @quiz_title = quiz.title
      @matches = Match.where(quiz_id: match_id)
      @questions = helpers.select_questions(match_id, @matches, quiz)
      @general_data = helpers.select_general_data(match_id, @matches)
      @general_graph_data = {"Acertos" => @general_data['correct_answers'], "Erros" => @general_data['wrong_answers']}
      @questions_graph_data = {"Questões respondidas" => @general_data['total_answers'], "Questões não respondidas" => @general_data['total_questions'] - @general_data['total_answers']}
      return @general_data, @general_graph_data, @questions_graph_data
    rescue => e
      render json: {"Erro": "Erro"}
    end
  end

  def players_show
    @player_id = params[:player_id]
    @quiz_id = params[:match_id]
    quiz = Quiz.find(@quiz_id)
    @player = Player.find(@player_id)
    @quiz_title = quiz.title
    matches = Match.where(player_id: @player_id)
    @data = helpers.select_personal_data(matches)
    render json: @data
  end

  def match_params
    params.require(:match).permit(:quiz_id, :player_id, :start_time, results: {})
  end
end
