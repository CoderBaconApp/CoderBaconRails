require "spec_helper"

describe MessagesController do
  describe "GET #index" do
    let(:convo) { create :conversation }
    let(:me) { create :user }
    let(:user) { create :user }
    let(:user2) { create :user }

    before do
      create :listener, user: me, conversation: convo
      create :listener, user: user, conversation: convo
    end

    context "when the user is signed in" do
      before { sign_in me }
      subject { req; response }

      context "asking for a conversation" do
        let(:req) { get :index, conversation_id: convo.id }
        it { should be_success }
      end

      it "throws routing error when asking for a nonexistant conversation" do
        expect { get :index, conversation_id: 123 }.to raise_error ActionController::RoutingError
      end

      it "seeing messages from ourself" do
        expect { get :index, user_id: me.id }.to raise_error ActionController::RoutingError
      end

      context "messaging a user we have a convo with" do
        let(:req) { get :index, user_id: user.id }
        it { should be_success }
        pending it "should return the existing convo path with the view"
      end

      context "messaging a user we don't have a convo with" do
        let(:req) { get :index, user_id: user2.id }
        it { should be_success }
        pending it "should return the new convo path with the view"
      end

      it "throws routing error when messaging a nonexistant user" do
        expect { get :index, user_id: 123 }.to raise_error ActionController::RoutingError
      end
    end

    context "when the user is not signed in" do
      pending "should redirect to the sign in page"
    end
  end
end
