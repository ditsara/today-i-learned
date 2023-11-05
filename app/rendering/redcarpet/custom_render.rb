class Redcarpet::CustomRender < Redcarpet::Render::HTML
  include Rails.application.routes.url_helpers

  # auto-links hash tags to an associated listing of Posts
  def postprocess(full_document)
    full_document.gsub HashTag::Scanner::MATCHER do |match|
      param = HashTag.format(match)
      "<a href='#{hash_tag_u_posts_path(param)}'>#{match}</a>"
    end
  end
end
