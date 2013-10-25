require "spec_helper"

describe PhoneCallsController do
  describe "routing" do

    it "routes to #index" do
      get("/phone_calls").should route_to("phone_calls#index")
    end

    it "routes to #new" do
      get("/phone_calls/new").should route_to("phone_calls#new")
    end

    it "routes to #show" do
      get("/phone_calls/1").should route_to("phone_calls#show", :id => "1")
    end

    it "routes to #edit" do
      get("/phone_calls/1/edit").should route_to("phone_calls#edit", :id => "1")
    end

    it "routes to #create" do
      post("/phone_calls").should route_to("phone_calls#create")
    end

    it "routes to #update" do
      put("/phone_calls/1").should route_to("phone_calls#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/phone_calls/1").should route_to("phone_calls#destroy", :id => "1")
    end

  end
end
