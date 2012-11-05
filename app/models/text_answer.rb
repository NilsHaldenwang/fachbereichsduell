class TextAnswer < ActiveRecord::Base
  attr_accessible :content, :count, :state

  belongs_to :question

  define_constants_for_attribute(:state, :hidden, :visible)
end

