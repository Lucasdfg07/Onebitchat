class TalksController < ApplicationController
  before_action :set_talk, only: [:show]

  def show
    authorize! :read, @talk
  end

  private

  def set_talk
    @talk = Talk.find_by(user_one_id: [params[:id], current_user.id], user_two_id: [params[:id], current_user.id], team: params[:team_id])
  end
end