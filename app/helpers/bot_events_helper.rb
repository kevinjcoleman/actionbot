module BotEventsHelper
  def address_form_helper
    @event.addresses.any? ? @event.addresses.first.to_s : nil
  end

  def datetime_form_helper(column)
    @event.time_windows.any? ? @event.time_windows.first.send(column).to_formatted_s(:long_ordinal) : nil
  end
end
