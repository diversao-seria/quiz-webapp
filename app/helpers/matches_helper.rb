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

  def select_questions(id, matches)
    questions = Question.where(:quiz_id => id)
    matches_questions = init_matches_data(matches)
    questions_list = []

    questions.each do |question|
      correct = 0
      total = 0
      average_time = []
      wrong_answers = []
      helps_used = []

      matches_questions.each do |match_question|
        if match_question['question_id'] === question.id
          if match_question['correct']
            correct += 1
          else
            wrong_answers.push(match_question['selected_alternative'])
          end
          total += 1
          average_time.push(match_question['response_time'])
          helps_used.push(match_question['help_used'])
        end
      end
      questions_list.push(
        {
          'title' => question.title,
          'id' => question.id,
          'correct' => correct,
          'total_answers' => total,
          'average_time' => average_time.reduce(:+).to_f / average_time.size,
          'most_wrong_answer' => wrong_answers.max_by { |i| wrong_answers.count(i) },
          'help_used' => helps_used
        })
    end
    return questions_list
  end

  def select_general_data(data)
    results = []

    data.each do |d|
      results.push(d.results)
    end
    total_answers = 0
    total_correct = 0

    results.each do |result|
      total_answers += result['total_questions']
      total_correct += result['total_correct_questions']
    end
    return {
      'total_matches' => data.size,
      'total_answers' => total_answers,
      'correct_answers' => total_correct,
      'wrong_answers' => total_answers - total_correct,
      'percentual' => ((total_correct / total_answers.to_f) * 100).to_int
    }
  end
end