class MatchesController < ApplicationController

  def index
    @id = params[:quiz]
    if @id == nil or @id == ""
      return redirect_to(root_url)
    end
    @quiz_title = Quiz.find(@id).title
    @matches = Match.where(quiz_id: @id)
    @players = @matches.size
    helpers.init_matches_data(@matches)
    @questions = helpers.select_questions(@id, @matches)
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
