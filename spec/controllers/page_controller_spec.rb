require 'spec_helper'

describe PageController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'pcall'" do
    it "returns http success" do
      get 'pcall'
      response.should be_success
    end
  end

end
