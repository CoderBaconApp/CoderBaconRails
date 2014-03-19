require "spec_helper"

describe ConversationsController do
  describe "GET#index" do

    subject { get :index }

    context "the user is logged out" do
      its(:status) { should eq 302 }
    end

    context "the user is logged in" do
      let(:convo) { create :conversation }
      let(:me) { create :user }
      let(:user) { create :user }
      let(:user2) { create :user }

      before do
        create :listener, user: me, conversation: convo
        create :listener, user: user, conversation: convo
        sign_in me
        subject
      end

      its(:status) { should eq 200 }
      it { should render_template :index }
      it { expect(assigns(:conversations)[0].id).to be_equal convo.id }
    end
  end
end
