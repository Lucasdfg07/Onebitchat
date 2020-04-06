class User < ApplicationRecord
  has_many :teams
  has_many :messages
  has_many :talks, dependent: :destroy
  
  has_many :team_users, dependent: :destroy
  has_many :member_teams, through: :team_users, :source => :team


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def my_teams
    self.teams + self.member_teams
  end
end