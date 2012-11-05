class TextAnswer < ActiveRecord::Base
  attr_accessible :content, :count, :state

  belongs_to :question

  STATE_HIDDEN = "hidden"
  STATE_VISIBLE = "visible"

  def hidden?
    self.state == STATE_HIDDEN
  end

  def visible?
    self.state == STATE_VISIBLE
  end
end

