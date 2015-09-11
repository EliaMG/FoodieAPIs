class ApisController < ApplicationController


  NPR_SEARCH = "http://api.npr.org/query?id=1053&searchTerm="
  NPR_OUTPUT = "&sort=dateDesc&output=JSON&searchType=mainText&apiKey="

  def seattle
    # begin
      npr_response = HTTParty.get(NPR_SEARCH + "Seattle" + NPR_OUTPUT + ENV["NPR_API"])
      @npr_data = munge_npr(npr_response)
    #   code = :ok
    # rescue
    #   @npr_data = {}
    #   code = :no_content
    # end
    # nyt_response =
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

  def munge_npr(response)
    stories = response.fetch["list"]["story"], {}
    stories.map do |story|
      {
        link: story.fetch("link", ""),
        title: story.fetch("title", ""),
        teaser: story.fetch("teaser", ""),
        date: story.fetch("storyDate", ""),
        image: story.fetch("image", ""),
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
