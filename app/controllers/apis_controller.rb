class ApisController < ApplicationController


  NPR_SEARCH = "http://api.npr.org/query?id=1053&searchTerm="
  NPR_OUTPUT = "&sort=dateDesc&output=JSON&searchType=mainText&apiKey="

  NYT_SEARCH = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q="
  NYT_TRAVEL = '&fq=news_desk:("Travel")&api-key='
  NYT_FOOD = '&fq=news_desk:("Food")&api-key='

# http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=search term&fq=filter-field:(filter-term)&additional-params=values]&api-key=####
# &fq=news_desk:("Food")AND glocations:("SEATTLE")
  def seattle
    @npr_data = get_npr("Seattle")

    @nyt_response = get_nyt_travel("Seattle")

    #   code = :ok
    # rescue
    #   @npr_data = {}
    #   code = :no_content
    # end
  end

  # def search
  #   begin
  #     response = HTTParty.get(NPR+ query:  + "&output=JSON&searchType=mainText&apiKey=" +  ){ "by" => "artist", "q" => params[:artist] })
  #     data = setup_data(response)
  #     code = :ok
  #   rescue
  #     data = {}
  #     code = :no_content
  #   end
  #
  #   render json: data.as_json, code: code
  # end

  private

  def get_npr(city)
    npr_response = HTTParty.get(NPR_SEARCH + city + NPR_OUTPUT + ENV["NPR_API"])
    munge_npr(npr_response)
  end

  def get_nyt_travel(city)
    url = NYT_SEARCH + city + NYT_TRAVEL + ENV["NYT_API"]
    nyt_response = HTTParty.get(url)
  end

  def get_nyt_food(city)

  end

  def munge_npr(response)
    hash = JSON.parse(response)
    stories = hash["list"]["story"]
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
  #   jams = response.fetch "jams", {}
  #
  #   if response["list"]["next"].nil?
  #     return jams
  #   else
  #     jams = jams.first(10)
  #   end
  #
  #   jams.map do |jam|
  #     {
  #       via: jam.fetch("via", ""),
  #       url: jam.fetch("viaUrl", ""),
  #       title: jam.fetch("title", ""),
  #       artist: jam.fetch("artist", "")
  #     }
  #   end
  # end

end
