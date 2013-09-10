require "spec_helper"

describe SitePagesController do
  describe "routing" do

    it "routes to #index" do
      get("/site_pages").should route_to("site_pages#index")
    end

    it "routes to #new" do
      get("/site_pages/new").should route_to("site_pages#new")
    end

    it "routes to #show" do
      get("/site_pages/1").should route_to("site_pages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/site_pages/1/edit").should route_to("site_pages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/site_pages").should route_to("site_pages#create")
    end

    it "routes to #update" do
      put("/site_pages/1").should route_to("site_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/site_pages/1").should route_to("site_pages#destroy", :id => "1")
    end

  end
end
