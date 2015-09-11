class ApisController < ApplicationController


    NPR_SEARCH = "http://api.npr.org/query?id=1053&searchTerm="
    NPR_OUTPUT = "output=JSON&searchType=mainText&apiKey="
    #JAM = "http://api.thisismyjam.com/1/search/jam.json"
    # RANDO = "http://api.thisismyjam.com/1/explore/chance.json"
    # POPULAR = "http://api.thisismyjam.com/1/explore/popular.json"
    #
    def seattle
      # npr_response = HTTParty.get(NPR_SEARCH + "Seattle" + NPR_OUTPUT + ENV["NPR_API"])
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
    #
    # def randomizer
    #   apiresponse(RANDO)
    # end
    #
    # def popular
    #   apiresponse(POPULAR)
    # end
    #
    # private
    #
    # def apiresponse(url)
    #   begin
    #     response = HTTParty.get(url)
    #     data = setup_data(response)
    #     code = :ok
    #   rescue
    #     data = {}
    #     code = :no_content
    #   end
    #
    #   render json: data.as_json, code: code
    # end
    #
    # def setup_data(response)
    #
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
