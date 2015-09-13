class ApisController < ApplicationController


  NPR_SEARCH = "http://api.npr.org/query?id=1053&searchTerm="
  NPR_OUTPUT = "&sort=dateDesc&output=JSON&searchType=mainText&apiKey="

  NYT_SEARCH = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q="
  NYT_TRAVEL_DESK = '&fq=news_desk:("Travel")&api-key='
  NYT_FOOD_DESK = '&fq=news_desk:("Food")&api-key='

  def seattle
    get_city_data("Seattle")
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
      hash = JSON.parse(response)
      all_stories = hash["response"]["docs"]
      return all_stories
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
          image: story.fetch("image", ""),
          text: story.fetch("fullText", "")
        }
      end
    end
end
