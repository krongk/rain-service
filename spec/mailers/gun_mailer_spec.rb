require "spec_helper"

describe GunMailer do
  describe "marketing" do
    let(:mail) { GunMailer.marketing }

    it "renders the headers" do
      mail.subject.should eq("Marketing")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
