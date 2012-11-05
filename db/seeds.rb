# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

questions = JSON.parse(File.read(Rails.root.join("config", "questions.json")))

questions.each_with_index do |q, i|
  if q["question_type"] == Question::QUESTION_TYPE_ESTIMATION
    Question.create!(q.merge({number: i+1}))
  elsif q["question_type"] == Question::QUESTION_TYPE_CHOICES
    answers = q.delete("answers")

    question = Question.create!(q.merge({number: i+1}))

    answers.each do |a|
      question.text_answers.create!(a)
    end
  else
    raise StandardError, "Bad question type: #{q.question_type}"
  end
end

GameState.create!(
  state: GameState::STATE_STARTING,
  team_1_points: 0,
  team_2_points: 0,
  team_1_x: 0,
  team_2_x: 0
)
