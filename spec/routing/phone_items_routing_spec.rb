require "spec_helper"

describe PhoneItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/phone_items").should route_to("phone_items#index")
    end

    it "routes to #new" do
      get("/phone_items/new").should route_to("phone_items#new")
    end

    it "routes to #show" do
      get("/phone_items/1").should route_to("phone_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/phone_items/1/edit").should route_to("phone_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/phone_items").should route_to("phone_items#create")
    end

    it "routes to #update" do
      put("/phone_items/1").should route_to("phone_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/phone_items/1").should route_to("phone_items#destroy", :id => "1")
    end

  end
end
