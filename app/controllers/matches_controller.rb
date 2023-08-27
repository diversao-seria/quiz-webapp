class MatchesController < ApplicationController

  def index
    @id = params[:quiz]
    quiz = Quiz.find(@id)
    @quiz_title = quiz.title
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
  end

  def create
    @match = Match.create(match_params)
    if @match.save
      render json: @match, status: :created
    else
      render json: @match.errors.messages, status: :unprocessable_entity
    end
  end

  def match_show
    @id = params[:match_id]
    return redirect_to(root_url) if @id.blank?

    begin
      quiz = Quiz.find(@id)
      @quiz_title = quiz.title
      @matches = Match.where(quiz_id: @id)
      @questions = helpers.select_questions(@id, @matches, quiz)
      @general_data = helpers.select_general_data(@id, @matches)
      @general_graph_data = {"Acertos" => @general_data['correct_answers'], "Erros" => @general_data['wrong_answers']}
      @questions_graph_data = {"Questões respondidas" => @general_data['total_answers'], "Questões não respondidas" => @general_data['total_questions'] - @general_data['total_answers']}
      render :matchshow
    rescue => e
      redirect_to '/quizzes'
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
    render :playershow
  end

  def match_params
    params.fetch(:match).permit(:quiz_id, :player_id, :start_time, results: {})
  end
end
