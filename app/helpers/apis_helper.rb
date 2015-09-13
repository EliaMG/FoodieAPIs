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
    date = messy_date.to_date.strftime("%b %d, %Y")

    story_array.push(title, link, photo, caption, teaser, date)
  end

  def parse_nyt_story(story)
    story_array = []
    title = story[:title]["main"]
    link = story[:link]

    unless story[:image].empty?
      story[:image].each do |image|
        if image["subtype"] == "wide"
          @incomplete_url = image["url"]
        else
          @incomplete_url = story[:image][0]["url"]
        end
        # elsif image["subtype"] == "thumbnail"
        #   incomplete_url = image["url"]
        #   @photo = "http://www.nytimes.com/" + incomplete_url
      end
        photo = "http://www.nytimes.com/" + @incomplete_url
    end

    teaser_with_tags = story[:teaser]
    teaser = strip_tags(teaser_with_tags)

    messy_date = story[:date]
    date = messy_date.to_date.strftime("%b %d, %Y")

    story_array.push(title, link, photo, teaser, date)
    return story_array
  end

end
