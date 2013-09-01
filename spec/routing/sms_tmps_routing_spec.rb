require "spec_helper"

describe SmsTmpsController do
  describe "routing" do

    it "routes to #index" do
      get("/sms_tmps").should route_to("sms_tmps#index")
    end

    it "routes to #new" do
      get("/sms_tmps/new").should route_to("sms_tmps#new")
    end

    it "routes to #show" do
      get("/sms_tmps/1").should route_to("sms_tmps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sms_tmps/1/edit").should route_to("sms_tmps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sms_tmps").should route_to("sms_tmps#create")
    end

    it "routes to #update" do
      put("/sms_tmps/1").should route_to("sms_tmps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sms_tmps/1").should route_to("sms_tmps#destroy", :id => "1")
    end

  end
end
