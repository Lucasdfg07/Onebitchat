class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, Team do |t|
        t.user_id == user.id || t.users.where(id: user.id).present?
      end
      can :destroy, Team, user_id: user.id

      can [:read, :create], Channel do |c|
        c.team.user_id == user.id || c.team.users.where(id: user.id).present?
      end
      can [:destroy, :update], Channel do |c|
        c.team.user_id == user.id || c.user_id == user.id
      end

      can [:read], Talk do |t|
        t.user_one_id == user.id || t.user_two_id == user.id
      end

      can [:create, :destroy], TeamUser do |t|
        t.team.user_id == user.id
      end
    end
  end
end