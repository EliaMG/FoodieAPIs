require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  it "loads the home page" do
    get :index
    expect(response.response_code).to eq 200
  end
end
