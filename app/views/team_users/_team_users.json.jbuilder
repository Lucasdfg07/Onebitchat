json.extract! team_user, :id, :user_id, :team_id, :created_at, :updated_at

json.user do
  json.extract! team_user.user, :id, :name, :email
end