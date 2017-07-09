class EventResponder
  include BotInfo
  include BotTemplates

  attr_accessor :message
  def initialize(message)
    @message = message
  end

  def respond!
    if bot.bot_events.any?
      respond_with_events
    else
      message.reply(text: "There aren't any events currently setup 😟")
    end
  end

  def respond_with_events
    message.reply(text: "Here's a list of events near you.")
    generic_template_with_elements(event_elements)
  end

  def event_elements
    bot.bot_events.map { |event| EventElement.new(event, sender).prospective }
  end
end
