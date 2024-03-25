# frozen_string_literal: true

class HashTagsUpdateJob < ApplicationJob
  queue_as :default

  def perform(*user_content_ids)
    user_content_ids.each do |id|
      uc = UserContent.find(id)
      HashTag::Scanner.update_links uc
    end
  end
end
