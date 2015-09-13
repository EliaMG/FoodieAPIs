module ApisHelper
  def parse_npr_story(story)
    story_array = []
    title = story[:title]["$text"]
    link = story[:link][0]["$text"]

    unless story[:image].empty?
      photo = story[:image][0]["src"]
      caption = story[:image][0]["caption"]["$text"]
    end

    teaser_with_tags = story[:teaser]["$text"]
    teaser = strip_tags(teaser_with_tags)

    messy_date = story[:date]["$text"]
    date = messy_date[0..15]

    story_array.push(title, link, photo, caption, teaser, date)
  end

end
