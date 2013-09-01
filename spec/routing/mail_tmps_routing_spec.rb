require "spec_helper"

describe MailTmpsController do
  describe "routing" do

    it "routes to #index" do
      get("/mail_tmps").should route_to("mail_tmps#index")
    end

    it "routes to #new" do
      get("/mail_tmps/new").should route_to("mail_tmps#new")
    end

    it "routes to #show" do
      get("/mail_tmps/1").should route_to("mail_tmps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mail_tmps/1/edit").should route_to("mail_tmps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mail_tmps").should route_to("mail_tmps#create")
    end

    it "routes to #update" do
      put("/mail_tmps/1").should route_to("mail_tmps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mail_tmps/1").should route_to("mail_tmps#destroy", :id => "1")
    end

  end
end
