# frozen_string_literal: true

# Represents a Reply. In our tree of content, a Reply node is always a
# descendant of a Post. It may either be a direct child of the Post, or a child
# of another Reply.
class UserContent::Reply < UserContent
  validates :owner, presence: true
  validates :parent, presence: true
  validates :title, presence: false

  # after_commit do
  #   broadcast_append_to [root, 'replies'],
  #     partial: 'u/posts/post_detail',
  #     locals: { post_reply: self },
  #     target: [root, 'replies']
  # end
end
