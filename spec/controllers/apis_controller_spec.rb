require 'rails_helper'
NPR_SEARCH = "http://api.npr.org/query?id=1053&searchTerm="
NPR_OUTPUT = "&sort=dateDesc&output=JSON&searchType=mainText&apiKey="

NYT_SEARCH = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q="
NYT_TRAVEL_DESK = '&fq=news_desk:("Travel")&api-key='
NYT_FOOD_DESK = '&fq=news_desk:("Food")&api-key='

RSpec.describe ApisController, type: :controller do

  describe "loads a city's page" do

    it "gets #seattle successfully" do
      VCR.use_cassette "seattle_response" do
        get :seattle
        expect(response.response_code).to eq 200
      end
    end

    it "gets #boston successfully" do
      VCR.use_cassette "boston_response" do
        get :boston
        expect(response.response_code).to eq 200
      end
    end

    it "gets #austin successfully" do
      VCR.use_cassette "austin_response" do
        get :austin
        expect(response.response_code).to eq 200
      end
    end

    it "gets #chicago successfully" do
      VCR.use_cassette "chicago_response" do
        get :chicago
        expect(response.response_code).to eq 200
      end
    end

    it "gets #louisville successfully" do
      VCR.use_cassette "louisville_response" do
        get :louisville
        expect(response.response_code).to eq 200
      end
    end
  end


  describe "interacting with the NPR API" do
    it "parses the response into an array" do
      VCR.use_cassette 'get_npr' do
        response = (controller.send(:get_npr, "Seattle"))

        expect(response).to be_an_instance_of Array
      end
    end
  end

  describe "interacting with the NYT API" do
    it "parses the response into an array" do
      VCR.use_cassette 'get_nyt' do
        response = (controller.send(:get_nyt, "Seattle", NYT_TRAVEL_DESK))

        expect(response).to be_an_instance_of Array
      end
    end
  end
end
