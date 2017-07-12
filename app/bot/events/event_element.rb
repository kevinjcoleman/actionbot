class EventElement
  include EventButtons

  attr_accessor :event, :sender

  def initialize(event, sender)
    @event = event
    @sender = sender
  end

  def prospective
    event_element(prospective_event_buttons)
  end

  def confirmed
    event_element(confirmed_event_buttons)
  end

  def prospective_event_buttons
    [learn_more_button,
     event_rsvp_button]
  end

  def confirmed_event_buttons
    [learn_more_button,
     cancel_rsvp_button,
     share_button]
  end

  def event_rsvp_button
    postback_button(title: 'RSVP', payload: "RSVP-#{event.id}")
  end

  def cancel_rsvp_button
    postback_button(title: 'Cancel RSVP', payload: "CANCEL-RSVP-#{event.id}")
  end

  def learn_more_button
    postback_button(title: 'Learn more', payload: "EVENT-LEARN-#{event.id}")
  end

  def postback_button(title: , payload: )
    {
      type:"postback",
      title:title,
      payload:payload
    }
  end

  def event_element(buttons)
    {title: event.name,
     image_url: event.picture_url,
     subtitle: "#{event.address.to_s}\n#{event.time_window.start_at.strftime('%m/%d/%Y at %l %P')} to #{event.time_window.end_at.strftime('%m/%d/%Y  at %l %P')}",
     buttons: buttons}
  end
end
