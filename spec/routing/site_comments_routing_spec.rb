require "spec_helper"

describe SiteCommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/site_comments").should route_to("site_comments#index")
    end

    it "routes to #new" do
      get("/site_comments/new").should route_to("site_comments#new")
    end

    it "routes to #show" do
      get("/site_comments/1").should route_to("site_comments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/site_comments/1/edit").should route_to("site_comments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/site_comments").should route_to("site_comments#create")
    end

    it "routes to #update" do
      put("/site_comments/1").should route_to("site_comments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/site_comments/1").should route_to("site_comments#destroy", :id => "1")
    end

  end
end
