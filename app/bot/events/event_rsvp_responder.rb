class EventRsvpResponder
  include BotInfo
  include EventButtons
  attr_accessor :message, :bot, :event
  def initialize(message, bot)
    @message, @bot = message, bot
    @event = BotEvent.find(event_id)
  end

  def respond!
    add_rsvp
    message.reply(attachment: {
                    type: 'template',
                    payload: {
                      template_type: 'button',
                      text: "Awesome #{sender.first_name}, I've recorded your RSVP to #{event.name}, we're looking forward to seeing you! 😀\nAt anytime you can see all your RSVPs by messaging 'RSVPS'.",
                      buttons: [share_button]
                    }
                  }
    )
  end

  def add_rsvp
    event.event_rsvps.create(sender_id: sender.id) unless event.event_rsvps.where(sender_id: sender.id).any?
  end

  def event_id
    message.payload.split('-').last.to_i
  end
end
