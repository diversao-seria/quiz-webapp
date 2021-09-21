class Match < ApplicationRecord
    belongs_to :quiz
    belongs_to :player
    store_accessor :results, :score

end
