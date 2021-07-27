class Match < ApplicationRecord
    belongs_to :quiz
    store_accessor :results, :score

end
