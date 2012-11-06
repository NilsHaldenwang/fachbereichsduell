class AdminController < ApplicationController
  before_filter :authenticate

  def index
    gs = GameState.instance
    @current_question = gs.current_question
    @game_state = gs
  end

  def change_state
    GameState.instance.update_attribute(:state, params[:state])
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
