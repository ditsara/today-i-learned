class HashTag < ApplicationRecord
  has_many :hash_tag_links, class_name: "HashTag::Link"
  has_many :user_contents, through: :hash_tag_links

  def self.format(str)
    str.parameterize separator: "_"
  end

  def name=(str)
    self[:name] = HashTag.format(str)
  end

  def name_with_hash
    "##{name}"
  end

  module Scanner
    module_function

    MATCHER = /(#+[a-zA-Z0-9(_)]{1,})/

    def extract_hashtags(str)
      str.scan(MATCHER).flatten
    end

    def update_links(user_content)
      scanned_hash_tags_strs = [user_content.title, user_content.body]
        .flat_map { extract_hashtags(_1) }.map { HashTag.format(_1) }.uniq
      current_hash_tag_strs = user_content.hash_tags.pluck(:name)

      # add links that don't already exist (and create HashTag objs if req'd)
      scanned_hash_tags_strs.each do |hash_tag_str|
        next if hash_tag_str.in? current_hash_tag_strs

        hash_tag = HashTag.find_or_create_by(name: hash_tag_str)
        HashTag::Link.create(hash_tag: hash_tag, user_content: user_content)
      end

      # remove links that are no longer applicable
      # NOTE: I'm sure there is an algorithmically more efficient way to do this
      removed_hash_tag_strs = current_hash_tag_strs - scanned_hash_tags_strs
      removed_hash_tag_strs.each do |hash_tag_str|
        hash_tag_to_remove = user_content.hash_tags.find_by(name: hash_tag_str)
        next unless hash_tag_to_remove
        user_content.hash_tag_links
          .find_by(hash_tag: hash_tag_to_remove)&.destroy
      end

      # finally return the hashtags which were found in the content
      scanned_hash_tags_strs
    end
  end # module Scanner
end
