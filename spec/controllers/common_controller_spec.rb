require 'spec_helper'

describe CommonController do

  describe "GET 'file_new'" do
    it "returns http success" do
      get 'file_new'
      response.should be_success
    end
  end

  describe "GET 'file_upload'" do
    it "returns http success" do
      get 'file_upload'
      response.should be_success
    end
  end

end
