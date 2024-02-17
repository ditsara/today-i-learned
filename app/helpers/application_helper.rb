module ApplicationHelper
  def humanize_datetime(dt)
    if 5.days.ago < dt && dt <= Time.now
      "#{time_ago_in_words dt} ago"
    else
      dt.strftime('%Y-%m-%d %H:%M')
    end
  end

  def action_text_pp(at_content)
    ActionText::Postprocess.postprocess(at_content)&.html_safe
  end
end
