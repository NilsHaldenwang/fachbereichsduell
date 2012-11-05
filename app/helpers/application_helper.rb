module ApplicationHelper
  def bootstrap_submit_button(text, name="submit", value="submit")
    "<button class='btn btn-primary btn-large btn-block' style='width: 100%;' name='#{name}' value='#{value}' type='submit'>#{text}</button>".html_safe
  end
end
