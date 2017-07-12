class BotEventCreationService
  include AddressParser
  include TimeParser
  attr_accessor :bot, :event_params, :event

  def initialize(bot, event_params)
    @bot, @event_params = bot, event_params
  end

  def create_event
    ActiveRecord::Base.transaction do
      @event = bot.bot_events.create!(event_creation_params)
      address_creator
      time_window_creator
    end
  end

  def event_creation_params
    event_params.slice(*BotEvent.params)
  end

  def address_creator
    parsed_address = parse_address(event_params[:address_line])
    event.create_address!(street: parsed_address.to_s(:line1),
                    city: parsed_address.city,
                    state: parsed_address.state,
                    country_code: "US",
                    zip: parsed_address.postal_code )
  end

  def time_window_creator
    event.create_time_window!(start_at: parsed_chronic_datetime(event_params[:start_at]), end_at: parsed_chronic_datetime(event_params[:end_at]))
  end
end
