# frozen_string_literal: true

module ActionText::Postprocess
  class PP
    include Rails.application.routes.url_helpers

    def postprocess(at_content)
      f = at_content&.body&.to_rendered_html_with_layout
      return unless f

      html_doc = Nokogiri::HTML::DocumentFragment.parse(f)

      html_doc.search('.//text()').reject { _1.parent&.name == 'a' }.each do |t|
        t_content_decorated =
          t.content.gsub HashTag::Scanner::MATCHER do |match|
            param = HashTag.format(match)
            "<a href='#{hash_tag_u_posts_path(param)}'>#{match}</a>"
          end

        next unless t_content_decorated != t.content

        t.replace Nokogiri::HTML::DocumentFragment.parse(t_content_decorated)
      end

      html_doc.to_html
    end
  end

  module_function

  def postprocess(at_content)
    PP.new.postprocess at_content
  end
end
