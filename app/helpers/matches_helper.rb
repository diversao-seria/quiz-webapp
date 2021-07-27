module MatchesHelper

  def init_matches_data(matches)
    arr = []
    matches.each do |match|
      match.results['questions_answered'].each do |data|
        arr.push(data)
      end
    end
    return arr
  end

  def select_questions(id,matches)
    questions = Question.where(:quiz_id => id)
    matches_questions = init_matches_data(matches)
    puts matches_questions
    questions_list = []
    questions.each do |question|
      matches_questions_list = []
      matches_questions.each do |match_question|
        if match_question['question_id'] === question.id
          matches_questions_list.push(match_question)
        end
      end
      questions_list.push({'question' => question.title, 'matches' => matches_questions_list})
    end
    return questions_list
  end

end
