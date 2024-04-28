# frozen_string_literal: true

# DEPRECATED
class Redcarpet::CustomRender < Redcarpet::Render::HTML
  include Rails.application.routes.url_helpers

  # auto-links hash tags to an associated listing of Posts
  # TODO: ignore if the hashtag is already linked.
  def postprocess(full_document)
    full_document.gsub HashTag::UpdateJob::Updater::MATCHER do |match|
      param = HashTag.format(match)
      "<a href='#{hash_tag_u_posts_path(param)}'>#{match}</a>"
    end
  end
end
