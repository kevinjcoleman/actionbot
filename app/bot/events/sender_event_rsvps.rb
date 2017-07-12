class SenderEventRsvps
  include BotInfo
  include BotTemplates

  attr_accessor :message
  def initialize(message)
    @message = message
  end

  def respond!
    if sender.event_rsvps.any?
      respond_with_sender_events
    elsif bot.bot_events.any?
      respond_with_bot_events
    else
      message.reply(text: "It looks like there aren't any events currently setup 😟")
    end
  end

  def respond_with_bot_events
    message.reply(text: "It looks like you aren't RSVPed to any events right now, here's a list of upcoming ones.")
    generic_template_with_elements(bot_event_elements)
  end

  def bot_event_elements
    bot.bot_events.map { |event| EventElement.new(event, sender).prospective }
  end

  def respond_with_sender_events
    message.reply(text: "Here's the events you're RSVPed to.")
    generic_template_with_elements(sender_event_elements)
  end

  def sender_event_elements
    sender.event_rsvps.map { |rsvp| EventElement.new(rsvp.bot_event, sender).confirmed }
  end
end
