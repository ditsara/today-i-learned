# frozen_string_literal: true

# NODOC
class HashTag::UpdateJob < ApplicationJob
  queue_as :default

  def perform(*user_content_ids)
    updater = Updater.new
    user_content_ids.each do |id|
      uc = UserContent.find_by(id:)
      next unless uc

      updater.update_links uc
    end
  end

  # Internal class to update db HashTag and HashTag::Link based on the
  # scanned content (of UserContent)
  class Updater
    MATCHER = /(#+[a-zA-Z0-9(_)]{1,})/

    def update_links(user_content)
      scanned_hash_tags_strs = scan_hash_tags(user_content)
      current_hash_tag_strs = user_content.hash_tags.pluck(:name)

      # add links that don't already exist (and create HashTag objs if req'd)
      added_hash_tag_strs = scanned_hash_tags_strs - current_hash_tag_strs
      add_hash_tags(user_content, added_hash_tag_strs)

      # remove links that are no longer applicable
      removed_hash_tag_strs = current_hash_tag_strs - scanned_hash_tags_strs
      remove_hash_tags(user_content, removed_hash_tag_strs)

      # finally return the hashtags which were found in the content
      scanned_hash_tags_strs
    end

    def scan_hash_tags(user_content)
      html_doc = Nokogiri::HTML.parse user_content.content.body&.to_html
      return [] unless html_doc

      body_hashtags = html_doc.search('//text()').map { extract_hashtags(_1.to_s) }
      title_hashtags = extract_hashtags user_content.title

      [body_hashtags, title_hashtags].flatten.map { HashTag.format(_1) }.uniq
    end

    def add_hash_tags(user_content, hash_tags)
      hash_tags.each do |hash_tag_str|
        next if hash_tag_str.in? user_content.hash_tags.pluck(:name)

        hash_tag = HashTag.find_or_create_by(name: hash_tag_str)
        HashTag::Link.create(hash_tag:, user_content:)
      end
    end

    # NOTE: I'm sure there is an algorithmically more efficient way to do this
    def remove_hash_tags(user_content, hash_tags)
      hash_tags.each do |hash_tag_str|
        hash_tag_to_remove = user_content.hash_tags.find_by(name: hash_tag_str)
        next unless hash_tag_to_remove

        user_content.hash_tag_links
          .find_by(hash_tag: hash_tag_to_remove)&.destroy
      end
    end

    def extract_hashtags(str)
      str.scan(MATCHER).flatten
    end
  end
end
