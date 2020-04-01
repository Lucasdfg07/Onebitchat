require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    context "team exists" do
      context "User is the owner of the team" do
        it "Returns success" do
          team = create(:team, user: @current_user)
          get :show, params: {slug: team.slug}

          expect(response).to have_http_status(:success)
        end
      end

      context "User is member of the team" do
        it "Returns success" do
          team = create(:team)
          team.users << @current_user
          get :show, params: {slug: team.slug}

          expect(response).to have_http_status(:success)
        end
      end

      context "User is not the owner or member of the team" do
        it "Redirects to root" do
          team = create(:team)
          get :show, params: {slug: team.slug}

          expect(response).to redirect_to('/')
        end
      end
    end

    context "team don't exists" do
      it "Redirects to root" do
        team_attributes = attributes_for(:team)
        get :show, params: { slug: team_attributes[:slug] }

        expect(response).to redirect_to('/')
      end
    end

  end

  describe "POST #create" do
    before(:each) do
      @team_attributes = attributes_for(:team, user: @current_user)
      post :create, params: {team: @team_attributes}
    end

    it "Redirect to new team" do
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/#{@team_attributes[:slug]}")
    end

    it "Create team with right attributes" do
      expect(Team.last.user).to eql(@current_user)
      expect(Team.last.slug).to eql(@team_attributes[:slug])
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "User is the Team Owner" do
      it "returns http success" do
        team = create(:team, user: @current_user)
        delete :destroy, params: {id: team.id}
        expect(response).to have_http_status(:success)
      end
    end

    context "User isn't the team Owner" do
      it "returns http forbidden" do
        team = create(:team)
        delete :destroy, params: {id: team.id}
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "User is member of the team" do
      it "returns http forbidden" do
        team = create(:team)
        team.users << @current_user
        delete :destroy, params: {id: team.id}
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end