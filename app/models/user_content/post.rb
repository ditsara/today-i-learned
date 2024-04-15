# frozen_string_literal: true

# Represents a Post. In our tree of content, a Post node is always a root node.
# Any children/descendants underneath this must be a Reply.
class UserContent::Post < UserContent
  validates :owner, presence: true

  def presentation_title
    (title.presence || content&.to_plain_text)&.truncate(50, separator: ' ')
  end

  def replies
    descendants.where(type: 'UserContent::Reply')
  end
end
