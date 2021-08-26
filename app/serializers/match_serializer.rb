class MatchSerializer < ActiveModel::Serializer
  attributes :id, :quiz_id, :player_id, :start_time, :results
end
