class TextAnswer < ActiveRecord::Base
  attr_accessible :content, :count, :state

  belongs_to :question
end
