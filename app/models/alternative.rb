class Alternative < ApplicationRecord
  belongs_to :question

  after_initialize :set_alternative_correct

  private
  
  def set_alternative_correct
    self.correct ||= false
  end
end
