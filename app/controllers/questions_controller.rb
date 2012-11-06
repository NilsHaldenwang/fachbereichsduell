class QuestionsController < ApplicationController
  def show
    @game_state = GameState.instance

    if @game_state.guessing? || @game_state.guessing_with_choices?
      @question = @game_state.current_question

      if @question.choices?
        render 'choices'
      elsif @question.estimation?
        render 'estimation'
      end
    else
      render 'please_wait'
    end
  end

  def reload_check
  end

  def submit_answer
  end
end
