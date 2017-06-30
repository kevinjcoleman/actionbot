class EventRsvpResponder
  attr_accessor :message, :bot, :event
  def initialize(message, bot)
    @message, @bot = message, bot
    @event = BotEvent.find(event_id)
  end

  def respond!
    message.reply(text: "I've recorded your RSVP to #{event.name}, we're looking forward to seeing you! 😀")
  end

  def event_id
    message.payload.split('-').last.to_i
  end
end
