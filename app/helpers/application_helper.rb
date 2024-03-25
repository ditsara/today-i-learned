# frozen_string_literal: true

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

  # I can't find a way to customize the default resourceful path for an AR
  # model. When I call `form_with model: @post`, the framework is looking for
  # `user_content_posts_path` or `user_content_post_path(@post)`. These don't
  # exist in my routing scheme.
  #
  # This method allows me to write:
  # `form_with model: @post, url: custom_polymorphic_path(@post)`
  #
  # This will then call the correct (create or update) route, depending on
  # whether the model is persisted.
  def custom_polymorphic_path(model)
    prefix =
      case model.class.to_s
      when 'UserContent::Post'
        'u_post'
      when 'UserContent::Reply'
        'u_post_reply'
      end

    return unless prefix

    if model.persisted?
      send "#{prefix}_path"
    else
      send "#{prefix.pluralize}_path"
    end
  end
end
