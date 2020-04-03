class TeamUsersController < ApplicationController
  before_action :set_team_user, only: [:destroy]

  def create
    @team_user = TeamUser.new(team_user_params)
    authorize! :create, @team_user

    respond_to do |format|
      if @team_user.save
        format.json { head :ok }
      else
        format.json { render json: @team_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @team_user
    @team_user.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_team_user
    @team_user = TeamUser.find_by(params[:user_id], params[:team_id])
  end

  def team_user_params
    params.require(:team_user).permit(:team_id, :user_id)
  end
end