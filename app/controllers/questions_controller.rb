class QuestionsController < ApplicationController

  def show_question
    respond_to do |format|
      format.html
      format.js { render :question }
    end
  end

  def remove_question
    respond_to do |format|
      format.html
      format.js { }
    end
  end

end
