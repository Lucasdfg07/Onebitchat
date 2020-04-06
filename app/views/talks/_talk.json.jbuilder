json.extract! talk, :id, :user_one_id, :user_two_id, :team_id, :created_at, :updated_at

json.user do
  @user = (current_user == talk.user_one)? talk.user_two : talk.user_one
  json.extract! @user, :id, :name, :email
end


json.messages do
  json.array! talk.messages do |message|
    json.extract! message, :id, :body, :user_id
    json.date message.created_at.strftime("%d/%m/%y")
    json.user do
      json.extract! message.user, :id, :name, :email
    end
  end
end