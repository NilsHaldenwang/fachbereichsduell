class PresentationController < ApplicationController
  def index
    render :index, layout: false
  end

  def view_state
    view_state = nil

    # case GameState.instance.state
    # when GameState::STATE_STARTING
    #   view_state = "starting"
    # when GameState::STATE_SHOWING_QUESTION
    #   view_state = "showing_question"
    # end

    render json: { "view_state" => GameState.instance.state }
  end

  def guessing
    @current_question = GameState.instance.current_question

    if @current_question.estimation?
      render partial: 'showing_question', layout: false, locals: { question: @current_question }
    elsif @current_question.choices?
      @answers = @current_question.text_answers.where("count > 0").order("count DESC")
      render partial: 'guessing', layout: false, locals: { question: @current_question, answers: @answers }
    end
  end

  def guessing_with_choices
    @current_question = GameState.instance.current_question
    @answers = @current_question.text_answers.where("count > 0").order("count DESC")
    @choices = @answers.map(&:content).shuffle.join(", ")
    render partial: 'guessing', layout: false, locals: { question: @current_question, answers: @answers, choices: @choices }
  end

  def showing_answers
    @current_question = GameState.instance.current_question

    if @current_question.estimation?
      render partial: 'showing_estimation_answer', layout: false, locals: { question: @current_question }
    elsif @current_question.choices?
      @answers = @current_question.text_answers.where("count > 0").order("count DESC")
      render partial: 'showing_answers', layout: false, locals: { question: @current_question, answers: @answers }
    end
  end

  def answer_state
    answer = TextAnswer.find(params[:id])

    if answer.visible?
      result = {
        visible: true,
        content: answer.content,
        normalized_points: answer.normalized_points
      }
    else
      result = {
        visible: nil
      }
    end

    render json: result
  end

  def starting
    render partial: 'starting', layout: false
  end

  def points_and_xes
    @gs = GameState.instance
    render json: {
      team_1_points_and_xes: "#{@gs.team_1_points} #{'X'*@gs.team_1_x}",
      team_2_points_and_xes: "#{'X'*@gs.team_2_x} #{@gs.team_2_points}"
    }
  end

  def round
    round = ( GameState.instance.current_question.number - 1 ) / 2 + 1
    if GameState.instance.starting?
      render json: { round: "" }
    else
      render json: { round: "Runde #{round}" }
    end
  end

  def showing_question
    @question = GameState.instance.current_question
    render partial: 'showing_question', locals: { question: @question }
  end
end
