module ApisHelper
  def parse_npr_story(story)
    story_array = []
    title = story[:title]["$text"]
    link = story[:link][0]["$text"]
    photo = story[:image][0]["src"]
    caption = story[:image][0]["caption"]["$text"]
    teaser = story[:teaser]["$text"]
    story_array.push(title, link, photo, caption, teaser)
  end

end
