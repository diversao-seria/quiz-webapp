class Question < ApplicationRecord
  belongs_to :quiz
  has_many :alternatives, dependent: :destroy
  accepts_nested_attributes_for :alternatives, allow_destroy: true

  after_initialize :build_alternatives, :if => :alternatives_within_limit?

  private

  def build_alternatives
    self.alternatives.build
  end

  def alternatives_within_limit?
    self.alternatives.to_a.count < 4
  end
end
