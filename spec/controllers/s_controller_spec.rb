require 'spec_helper'

describe SController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'page'" do
    it "returns http success" do
      get 'page'
      response.should be_success
    end
  end

  describe "GET 'post'" do
    it "returns http success" do
      get 'post'
      response.should be_success
    end
  end

end
