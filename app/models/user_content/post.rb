# Represents a Post. In our tree of content, a Post node is always a root node.
# Any children/descendants underneath this must be a Reply.
class UserContent::Post < UserContent
  scope :recents, -> { order(created_at: :desc) }
  validates :owner, presence: true

  def presentation_title
    (title.presence || body).truncate(50, separator: " ")
  end

  def replies
    descendants.where(type: "UserContent::Reply")
  end
end
