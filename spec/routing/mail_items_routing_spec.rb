require "spec_helper"

describe MailItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/mail_items").should route_to("mail_items#index")
    end

    it "routes to #new" do
      get("/mail_items/new").should route_to("mail_items#new")
    end

    it "routes to #show" do
      get("/mail_items/1").should route_to("mail_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mail_items/1/edit").should route_to("mail_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mail_items").should route_to("mail_items#create")
    end

    it "routes to #update" do
      put("/mail_items/1").should route_to("mail_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mail_items/1").should route_to("mail_items#destroy", :id => "1")
    end

  end
end
