class EventRsvpCanceler
  include BotInfo
  attr_accessor :message, :event
  def initialize(message)
    @message = message
    @event = BotEvent.find(event_id)
  end

  def cancel!
    cancel_rsvp
    message.reply(text: "I'm sad that you won't be able to attend #{sender.first_name} 😔. I've canceled your RSVP to #{event.name}. Hopefully you can come to another in the future.")
    menu_quick_reply('Is there another way you\'d like to participate? If not, no worries, you can always come back later 😀!')
  end

  def cancel_rsvp
    sender.event_rsvps.find_by(bot_event_id: event_id).destroy
  end

  def event_id
    message.payload.split('-').last.to_i
  end
end
