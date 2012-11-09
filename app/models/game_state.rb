class GameState < ActiveRecord::Base
  attr_accessible :state, :team_1_points, :team_1_x, :team_2_points, :team_2_x, :question_number

  define_constants_for_attribute(:state, :starting, :showing_question, :guessing, :guessing_with_choices, :showing_answers, :game_over)

  def GameState.instance
    GameState.first
  end

  def current_question
    Question.find_by_number(self.question_number)
  end
end
