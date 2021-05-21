class Question < ApplicationRecord
  belongs_to :quiz
  has_many :alternatives
  accepts_nested_attributes_for :alternatives

end
