class DashboardController < ApplicationController
    before_action :authorize
    def index
        @id = params[:quiz]
        if @id == nil or @id == ""
            return redirect_to(root_url)
        end
        @quiz_title = Quiz.find(@id).title
        @matches = Match.where(quiz_id: @id)
        #render json: @matches
    end
end
