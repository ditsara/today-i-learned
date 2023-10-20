# Represents a Reply. In our tree of content, a Reply node is always a
# descendant of a Post. It may either be a direct child of the Post, or a child
# of another Reply.
class UserContent::Reply < UserContent
  validates :owner, presence: true
  validates :parent, presence: true
  validates :title, presence: false
end
