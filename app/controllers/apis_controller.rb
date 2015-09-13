class ApisController < ApplicationController


  NPR_SEARCH = "http://api.npr.org/query?id=1053&searchTerm="
  NPR_OUTPUT = "&sort=dateDesc&output=JSON&searchType=mainText&apiKey="

  NYT_SEARCH = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q="
  NYT_TRAVEL_DESK = '&fq=news_desk:("Travel")&api-key='
  NYT_FOOD_DESK = '&fq=news_desk:("Food")&api-key='

  def seattle
    get_city_data("Seattle")
  end

  def chicago
    get_city_data("Chicago")
  end

  def boston
    get_city_data("Boston")
  end

  def austin
    get_city_data("Austin")
  end
    # begin
    #   code = :ok
    # rescue
    #   @npr_data = {}
    #   code = :no_content
    # end
    #   render json: data.as_json, code: code

private

    def get_city_data(city)
      @npr_data = get_npr(city)

      @nyt_travel = get_nyt(city, NYT_TRAVEL_DESK)
      @nyt_food = get_nyt(city, NYT_FOOD_DESK)
    end

    def get_npr(city)
      url = NPR_SEARCH + city + NPR_OUTPUT + ENV["NPR_API"]
      npr_response = HTTParty.get(url)
      munge_npr(npr_response)
    end

    def get_nyt(city, desk)
      url = NYT_SEARCH + city + desk + ENV["NYT_API"]
      nyt_response = HTTParty.get(url)
      munge_nyt(nyt_response)
    end

    def munge_nyt(response)
      all_stories = response["response"]["docs"]
      stories = all_stories.first(5)
      stories.map do |story|
        {
          link: story.fetch("web_url", ""),
          title: story.fetch("headline", ""),
          teaser: story.fetch("snippet", ""),
          date: story.fetch("pub_date", ""),
          image: story.fetch("multimedia", "")
        }
      end
    end

    def munge_npr(response)
      hash = JSON.parse(response)
      all_stories = hash["list"]["story"]
      stories = all_stories.first(5)
      stories.map do |story|
        {
          link: story.fetch("link", ""),
          title: story.fetch("title", ""),
          teaser: story.fetch("teaser", ""),
          date: story.fetch("storyDate", ""),
          image: story.fetch("image", "")
        }
      end
    end
end
