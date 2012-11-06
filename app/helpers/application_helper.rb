module ApplicationHelper
  def bootstrap_submit_button(text, name="submit", value="submit")
    "<button class='btn btn-primary btn-large btn-block' style='width: 100%;' name='#{name}' value='#{value}' type='submit'>#{text}</button>".html_safe
  end

  def bootstrap_admin_button_form(text, url, post_params = {}, css_classes="btn-primary")
    render partial: "admin/post_button", locals: { text: text, url: url, post_params: post_params, css_classes: css_classes }
  end
end
