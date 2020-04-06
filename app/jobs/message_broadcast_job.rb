class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    m = message.messagable
    chat_name = (m.class == Channel)? "#{m.team.id}_channels_#{m.id}" : "#{m.team.id}_talks_#{m.id}"
    ActionCable.server.broadcast(chat_name, {
                                          message: message.body,
                                          date: message.created_at.strftime("%d/%m/%y"),
                                          name: message.user.name
                                        })
  end
end
