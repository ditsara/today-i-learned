module ActionText::Postprocess
  class PP
    include Rails.application.routes.url_helpers

    def postprocess(at_content)
      html_doc = Nokogiri::HTML::DocumentFragment.parse(at_content&.body&.to_html)
      return unless html_doc

      html_doc.search('//text()').reject { _1.parent&.name == 'a' }.each do |t|
        x = t.content.gsub HashTag::Scanner::MATCHER do |match|
          param = HashTag.format(match)
          "<a href='#{hash_tag_u_posts_path(param)}'>#{match}</a>"
        end
        t.parent&.children = Nokogiri::HTML::DocumentFragment.parse(x).children
      end
debugger
      html_doc.css('.trix-content').to_html
    end
  end

  module_function

  def postprocess(at_content)
    PP.new.postprocess at_content
  end
end
