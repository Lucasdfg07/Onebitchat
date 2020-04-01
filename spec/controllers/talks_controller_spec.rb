require 'rails_helper'

RSpec.describe TalksController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'

    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end

  describe "GET #show" do
    # Sem isto os testes não renderizam o json
    render_views

    context "Is talk member" do
      before(:each) do
        @team = create(:team)
        @guest_user = create(:user)
        @team.users << @guest_user
        @talk = create(:talk, user_one: @current_user, user_two: @guest_user, team: @team)

        @message1 = build(:message)
        @message2 = build(:message)
        @talk.messages << [@message1, @message2]

        get :show, params: {id: @guest_user, team_id: @team.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "Return the right params" do
        response_hash = JSON.parse(response.body)

        expect(response_hash["user_one_id"]).to eql(@current_user.id)
        expect(response_hash["user_two_id"]).to eql(@guest_user.id)
        expect(response_hash["team_id"]).to eql(@team.id)
      end

      it "Return the right number of messages" do
        response_hash = JSON.parse(response.body)
        expect(response_hash["messages"].count).to eql(2)
      end

      it "Return the right messages" do
        response_hash = JSON.parse(response.body)
        expect(response_hash["messages"][0]["body"]).to eql(@message1.body)
        expect(response_hash["messages"][0]["user_id"]).to eql(@message1.user.id)
        expect(response_hash["messages"][1]["body"]).to eql(@message2.body)
        expect(response_hash["messages"][1]["user_id"]).to eql(@message2.user.id)
      end
    end

    context "Isn't talk member" do
      before(:each) do
        @team = create(:team)
        @guest_user = create(:user)
        @team.users << @guest_user
        @talk = create(:talk, user_two: @guest_user, team: @team)

        get :show, params: {id: @guest_user, team_id: @team.id}
      end

      it "returns http forbidden" do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

end