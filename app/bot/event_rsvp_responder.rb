class EventRsvpResponder
  include BotInfo
  attr_accessor :message, :bot, :event
  def initialize(message, bot)
    @message, @bot = message, bot
    @event = BotEvent.find(event_id)
  end

  def respond!
    add_rsvp
    message.reply(text: "Awesome #{sender.first_name}, I've recorded your RSVP to #{event.name}, we're looking forward to seeing you! 😀\n At anytime you can say your RSVPs by messaging 'RSVPS'.")
  end

  def add_rsvp
    event.event_rsvps.create(sender_id: sender.id) unless event.event_rsvps.where(sender_id: sender.id).any?
  end

  def event_id
    message.payload.split('-').last.to_i
  end
end
