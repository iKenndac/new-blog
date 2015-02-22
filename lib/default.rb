# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

require 'date'
require 'active_support/core_ext/integer/inflections'

module PostHelper

  def number_of_front_page_posts()
    return 10
  end

  def get_pretty_date(post)
    time = attribute_to_time(post[:created_at])
    time.strftime('%B') + " " + time.day.ordinalize + time.strftime(', %Y')
  end

  def get_pretty_date_short(post)
    time = attribute_to_time(post[:created_at])
    time.strftime('%b') + " " + time.day.ordinalize
  end

  def get_post_start(post)
    content = post.compiled_content
    if content =~ /\s<!-- more -->\s/
      content = content.partition('<!-- more -->').first +
      "<div class='read-more'><a href='#{post.path}'>Continue reading &rsaquo;</a></div>"
    end
    return content
  end

  def grouped_articles
    sorted_articles.group_by do |a|
      [ Time.parse(a[:created_at].to_s).year, Time.parse(a[:created_at].to_s).month ]
    end.sort.reverse
  end

end



include PostHelper
