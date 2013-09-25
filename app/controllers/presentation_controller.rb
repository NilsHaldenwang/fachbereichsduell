# encoding: UTF-8
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

    @answers = @current_question.estimation_answers.map(&:value).shuffle

    @min = @current_question.rounding_factor * ( @answers.min.to_i / @current_question.rounding_factor )
    @max = @current_question.rounding_factor * (@answers.max.to_i / @current_question.rounding_factor) + @current_question.rounding_factor

    # TODO: REMOVE FAKE ANTWORTEN
    100.times do |i|
      @answers << ((@max - @min) * rand + @min).round(2)
    end

    @mean = ( @answers.inject(:+) / @answers.size.to_f ).round(2)

    render partial: 'guessing', layout: false, locals: { question: @current_question, min: @min, max: @max, answers: @answers, mean: @mean }
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

  def president_answers
    @current_question = GameState.instance.current_question

    render json: {
      answer_luecke: @current_question.answer_luecke,
      answer_rollinger: @current_question.answer_rollinger
    }
  end


  def starting
    render partial: 'starting', layout: false
  end

  def points
    @gs = GameState.instance
    render json: {
      team_1_points: @gs.team_1_points,
      team_2_points: @gs.team_2_points,
    }
  end

  def round
    round = GameState.instance.current_question.number
    if GameState.instance.starting? || GameState.instance.game_over?
      render json: { round: "" }
    else
      render json: { round: "Frage #{round}" }
    end
  end

  def game_over
    team_1_points = GameState.instance.team_1_points
    team_2_points = GameState.instance.team_2_points

    winner = nil
    if team_1_points > team_2_points
      winner = "Prof. Rollinger"
    elsif team_2_points > team_1_points
      winner = "Prof. Lücke"
    else
      winner = "Jeder"
    end

    render partial: 'game_over', layout: false, locals: { winner: winner }
  end

  def showing_question
    @question = GameState.instance.current_question
    render partial: 'showing_question', locals: { question: @question }
  end
end
