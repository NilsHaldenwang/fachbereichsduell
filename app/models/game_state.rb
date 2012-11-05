class GameState < ActiveRecord::Base
  attr_accessible :state, :team_1_points, :team_1_x, :team_2_points, :team_2_x
end
