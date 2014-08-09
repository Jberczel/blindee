require "spec_helper"

describe InvitationMailer do
  describe "invitation" do
    let(:mail) { InvitationMailer.invitation }

    it "renders the headers" do
      mail.subject.should eq("Invitation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "notification" do
    let(:mail) { InvitationMailer.notification }

    it "renders the headers" do
      mail.subject.should eq("Notification")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
