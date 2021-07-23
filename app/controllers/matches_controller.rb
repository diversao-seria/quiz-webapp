class MatchesController < ApplicationController

  def create
    @match = Match.create(helpers.match_params)
    if @match.save
      render json: @match, status: :created
    else
      render json: @match.errors.messages, status: :unprocessable_entity
    end
  end

end
