require 'test_helper'

class ActionText::PostprocessTest < ActiveSupport::TestCase
  test 'decorates hashtags with links' do
    initial_html = "We've go a new #hashtag in town"

    at_content = ActionText::RichText.new body: initial_html
    r = ActionText::Postprocess.postprocess at_content

    assert r.match(/<a.*>#hashtag/)
  end

  test 'does not change existing links' do
    initial_html = "I'm already <a href='/'>#spoken</a> for"

    at_content = ActionText::RichText.new body: initial_html
    r = ActionText::Postprocess.postprocess at_content

    assert_equal Nokogiri::HTML::DocumentFragment.parse(initial_html).to_html,
                 Nokogiri::HTML::DocumentFragment.parse(r).to_html
  end

  test 'handles <br> tags' do
    initial_html = 'Unbalanced HTML tags<br>are strange<br />and controversial'

    at_content = ActionText::RichText.new body: initial_html
    r = ActionText::Postprocess.postprocess at_content

    assert_equal Nokogiri::HTML::DocumentFragment.parse(initial_html).to_html,
                 Nokogiri::HTML::DocumentFragment.parse(r).to_html
  end
end
