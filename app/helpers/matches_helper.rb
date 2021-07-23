module MatchesHelper
  def match_params
    params.require(:match).permit(:quiz_id, :start_time, results: {})
  end
end
