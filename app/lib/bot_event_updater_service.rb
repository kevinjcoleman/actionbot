class BotEventUpdaterService
  include AddressParser
  include TimeParser
  attr_accessor :bot, :event_params, :event

  def initialize(bot, event, event_params)
    @bot, @event, @event_params = bot, event, event_params
  end

  def update_event
    ActiveRecord::Base.transaction do
      event.update_attributes!(event_update_params)
      address_updator
      time_window_updator
    end
  end

  def event_update_params
    event_params.slice(*BotEvent.params)
  end

  def address_updator
    parsed_address = parse_address(event_params[:address_line])
    event.addresses.first.update_attributes!(street: parsed_address.to_s(:line1),
                    city: parsed_address.city,
                    state: parsed_address.state,
                    country_code: "US",
                    zip: parsed_address.postal_code )
  end

  def time_window_updator
    event.time_windows.first.update_attributes!(start_at: parsed_chronic_datetime(event_params[:start_at]), end_at: parsed_chronic_datetime(event_params[:end_at]))
  end
end
