require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'sms'" do
    it "returns http success" do
      get 'sms'
      response.should be_success
    end
  end

  describe "GET 'email'" do
    it "returns http success" do
      get 'email'
      response.should be_success
    end
  end

  describe "GET 'qq'" do
    it "returns http success" do
      get 'qq'
      response.should be_success
    end
  end

  describe "GET 'share'" do
    it "returns http success" do
      get 'share'
      response.should be_success
    end
  end

  describe "GET 'blog'" do
    it "returns http success" do
      get 'blog'
      response.should be_success
    end
  end

  describe "GET 'qq'" do
    it "returns http success" do
      get 'qq'
      response.should be_success
    end
  end

  describe "GET 'map'" do
    it "returns http success" do
      get 'map'
      response.should be_success
    end
  end

  describe "GET 'fenlei'" do
    it "returns http success" do
      get 'fenlei'
      response.should be_success
    end
  end

  describe "GET 'forum'" do
    it "returns http success" do
      get 'forum'
      response.should be_success
    end
  end

  describe "GET 'weibo'" do
    it "returns http success" do
      get 'weibo'
      response.should be_success
    end
  end

  describe "GET 'weixin'" do
    it "returns http success" do
      get 'weixin'
      response.should be_success
    end
  end

  describe "GET 'qa'" do
    it "returns http success" do
      get 'qa'
      response.should be_success
    end
  end

  describe "GET 'wiki'" do
    it "returns http success" do
      get 'wiki'
      response.should be_success
    end
  end

  describe "GET 'video'" do
    it "returns http success" do
      get 'video'
      response.should be_success
    end
  end

  describe "GET 'mobile'" do
    it "returns http success" do
      get 'mobile'
      response.should be_success
    end
  end

  describe "GET 'setting'" do
    it "returns http success" do
      get 'setting'
      response.should be_success
    end
  end

end
