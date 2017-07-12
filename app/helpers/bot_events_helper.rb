module BotEventsHelper
  def address_form_helper
    @event.address ? @event.address.to_s : nil
  end

  def datetime_form_helper(column)
    @event.time_window ? @event.time_window.send(column).to_formatted_s(:long_ordinal) : nil
  end
end
