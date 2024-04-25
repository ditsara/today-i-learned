# frozen_string_literal: true

module ApplicationHelper
  def humanize_datetime(dt)
    if 7.days.ago < dt && dt <= Time.now
      "#{time_ago_in_words dt} ago"
    else
      dt.strftime('%Y-%m-%d %H:%M')
    end
  end

  def action_text_pp(at_content)
    ActionText::Postprocess.postprocess(at_content)&.html_safe
  end

  # Use this to generate the correct path for a 
  # `form_with model: @model, url: [:namespace, pluralize_new(@model)]`
  def pluralize_new(model)
    elem = model.model_name.element
    (model.persisted? ? elem : elem.pluralize).to_sym
  end
end
