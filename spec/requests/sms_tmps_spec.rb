require 'spec_helper'

describe "SmsTmps" do
  describe "GET /sms_tmps" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get sms_tmps_path
      response.status.should be(200)
    end
  end
end
