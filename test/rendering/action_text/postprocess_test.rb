# frozen_string_literal: true
require 'test_helper'

class ActionText::PostprocessTest < ActiveSupport::TestCase
  test 'no change if no hashtags' do
    initial_html = 'Nothing to do'

    at_content = ActionText::RichText.new body: initial_html
    r = ActionText::Postprocess.postprocess at_content
    ndf = Nokogiri::HTML::DocumentFragment.parse(r)

    assert ndf.search('.//text()').find { _1.text.match initial_html }
  end

  test 'decorates hashtags with links' do
    initial_html = "We've go a new #hashtag in town"

    at_content = ActionText::RichText.new body: initial_html
    r = ActionText::Postprocess.postprocess at_content

    assert r.match(/<a.*>#hashtag/)
  end

  test 'does not change existing links' do
    initial_href = '/link/to/somewhere/else/'
    initial_html = "I'm already <a href='#{initial_href}'>#spoken</a> for"

    at_content = ActionText::RichText.new body: initial_html
    r = ActionText::Postprocess.postprocess at_content
    ndf = Nokogiri::HTML::DocumentFragment.parse(r)

    assert ndf.xpath('.//a').all? { _1.attributes['href'].value == initial_href }
  end

  test 'handles <br> tags' do
    initial_html = 'Unbalanced HTML tags<br>are strange<br />and controversial'

    at_content = ActionText::RichText.new body: initial_html
    r = ActionText::Postprocess.postprocess at_content
    ndf = Nokogiri::HTML::DocumentFragment.parse(r)

    assert ndf.search('.//text()').find { _1.text.match 'Unbalanced HTML tags' }
    assert ndf.search('.//text()').find { _1.text.match 'are strange' }
    assert ndf.search('.//text()').find { _1.text.match 'and controversial' }
  end
end
