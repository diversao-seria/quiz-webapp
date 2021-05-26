class QuizSerializer < ActiveModel::Serializer
  attributes :id, :title, :questions

  def questions
    ActiveModel::SerializableResource.new(object.questions, each_serializer: QuestionSerializer)
  end
end
