require 'test_helper'

class ActionText::PostprocessTest < ActiveSupport::TestCase
  test 'decorates hashtags with links' do
    initial_html = "We've go a new #hashtag in town"

    at_content = ActionText::RichText.new body: initial_html
    r = ActionText::Postprocess.postprocess at_content
    assert false
  end
end
