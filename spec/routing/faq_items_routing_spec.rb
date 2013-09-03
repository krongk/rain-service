require "spec_helper"

describe FaqItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/faq_items").should route_to("faq_items#index")
    end

    it "routes to #new" do
      get("/faq_items/new").should route_to("faq_items#new")
    end

    it "routes to #show" do
      get("/faq_items/1").should route_to("faq_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/faq_items/1/edit").should route_to("faq_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/faq_items").should route_to("faq_items#create")
    end

    it "routes to #update" do
      put("/faq_items/1").should route_to("faq_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/faq_items/1").should route_to("faq_items#destroy", :id => "1")
    end

  end
end
