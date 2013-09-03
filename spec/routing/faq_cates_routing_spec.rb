require "spec_helper"

describe FaqCatesController do
  describe "routing" do

    it "routes to #index" do
      get("/faq_cates").should route_to("faq_cates#index")
    end

    it "routes to #new" do
      get("/faq_cates/new").should route_to("faq_cates#new")
    end

    it "routes to #show" do
      get("/faq_cates/1").should route_to("faq_cates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/faq_cates/1/edit").should route_to("faq_cates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/faq_cates").should route_to("faq_cates#create")
    end

    it "routes to #update" do
      put("/faq_cates/1").should route_to("faq_cates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/faq_cates/1").should route_to("faq_cates#destroy", :id => "1")
    end

  end
end
