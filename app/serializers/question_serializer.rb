class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :alternatives

  def alternatives
    ActiveModel::SerializableResource.new(object.alternatives, each_serializer: AlternativeSerializer)
  end
end
