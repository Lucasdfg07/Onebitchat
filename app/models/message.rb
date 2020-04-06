class Message < ApplicationRecord
  belongs_to :messagable, polymorphic: true
  belongs_to :user

  
  validates_presence_of :body, :user
end