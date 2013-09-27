class AdminController < ApplicationController
  before_filter :authenticate

  def index
    gs = GameState.instance
    @current_question = gs.current_question
    @game_state = gs
  end

  def accept_president_answer
    gs = GameState.instance
    @current_question = gs.current_question
    @game_state = gs


    if params[:luecke].present?
      @current_question.update_attribute(:answer_luecke, params[:luecke].to_f)
    end

    if params[:rollinger].present?
      @current_question.update_attribute(:answer_rollinger, params[:rollinger].to_f)
    end

    redirect_to action: :index
  end

  def change_state
    GameState.instance.update_attribute(:state, params[:state])

    if GameState.instance.game_over?
      gs = GameState.instance

      cq = gs.current_question
      answers = cq.estimation_answers.map(&:value)
      mean = ( answers.inject(:+) / answers.size.to_f ).round(2)

      diff_luecke = ( cq.answer_luecke.abs - mean ).abs
      diff_rollinger = ( cq.answer_rollinger - mean ).abs

      if(diff_luecke < diff_rollinger)
        gs.team_2_points += 1
      else
        gs.team_1_points += 1
      end

      # reset xes
      gs.team_1_x = 0
      gs.team_2_x = 0

      gs.save
    end

    redirect_to action: :index
  end

  def assign_answer
    answer = TextAnswer.find(params[:answer_id])
    points = answer.normalized_points

    gs = GameState.instance

    if params[:team] == "1"
      gs.team_1_points += points
    elsif params[:team] == "2"
      gs.team_2_points += points
    end

    answer.visible!
    answer.update_attribute(:answered_by_team, params[:team])
    gs.save

    redirect_to action: :index
  end

  def remove_answer
    answer = TextAnswer.find(params[:answer_id])
    points = answer.normalized_points

    gs = GameState.instance

    if params[:team] == "1"
      gs.team_1_points -= points
    elsif params[:team] == "2"
      gs.team_2_points -= points
    end

    answer.update_attribute(:answered_by_team, nil)
    gs.save

    redirect_to action: :index
  end

  def remove_estimation_answer
    ea = EstimationAnswer.find(params[:answer_id])
    ea.destroy

    redirect_to action: :index
  end

  def update_points
    gs = GameState.instance

    cq = gs.current_question
    answers = cq.estimation_answers.map(&:value)
    mean = ( answers.inject(:+) / answers.size.to_f ).round(2)

    diff_luecke = ( cq.answer_luecke.abs - mean ).abs
    diff_rollinger = ( cq.answer_rollinger - mean ).abs

    if(diff_luecke < diff_rollinger)
      gs.team_2_points += 1
    else
      gs.team_1_points += 1
    end

    gs.save

    redirect_to action: :index
  end

  def next_question
    gs = GameState.instance

    gs.question_number += 1
    gs.state = GameState::STATE_SHOWING_QUESTION

    # reset xes
    gs.team_1_x = 0
    gs.team_2_x = 0

    gs.save

    redirect_to action: :index
  end

  def add_x
    gs = GameState.instance

    if params[:team] == "1"
      gs.team_1_x += 1
    elsif params[:team] == "2"
      gs.team_2_x += 1
    end

    gs.save

    redirect_to action: :index
  end

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |user, password|
      user == "nico" && password == "alumnusim"
    end
  end
end
