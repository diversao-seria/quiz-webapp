class MatchesController < ApplicationController

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
