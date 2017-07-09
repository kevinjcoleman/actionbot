class ApiAiResponder
  include BotInfo
  attr_accessor :message, :response
  def initialize(message: )
    @message = message
  end

  def respond!
    fetch_response
    respond_to_message
  end

  def fetch_response
    @response = client.text_request message.text
  end

  def respond_to_message
    puts "here's the api ai action: #{action}"
    if get_started?
      welcome_message
    elsif refresh?
      refresh_message
    elsif action?
      action_message
    elsif event?
      EventResponder.new(message).respond!
    elsif rsvps?
      SenderEventRsvps.new(message).respond!
    else
      missing_message
    end
  end

  def unknown_response?
    action == 'input.unknown'
  end

  def get_started?
    action == 'input.get_started'
  end

  def refresh?
    action == 'input.refresher'
  end

  def action?
    action == 'input.action'
  end

  def event?
    action == 'input.event'
  end

  def rsvps?
    action == 'input.rsvps'
  end

  def action
    response[:result][:action]
  end

  def client
    @client ||= ApiAiClient.new.client
  end
end
