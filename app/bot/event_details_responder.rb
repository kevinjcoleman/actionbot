class EventDetailsResponder
  attr_accessor :message, :bot, :event
  def initialize(message, bot)
    @message, @bot = message, bot
    @event = BotEvent.find(event_id)
  end

  def respond!
    message.reply(text: "Here's the additional details for #{event.name}\n#{event.description}")
  end

  def event_id
    message.payload.split('-').last.to_i
  end
end
