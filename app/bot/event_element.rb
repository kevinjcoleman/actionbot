class EventElement
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

  def share_button
    {
      type: "element_share",
      share_contents: {
       attachment: {
         type: 'template',
         payload: {
           template_type: 'generic',
           elements: [
             {
               title: "Would you join me at #{event.name}?",
               subtitle: "#{event.addresses.first.to_s}\n#{event.time_windows.first.start_at.strftime('%m/%d/%Y at %l %P')} to #{event.time_windows.first.end_at.strftime('%m/%d/%Y  at %l %P')}",
               image_url: event.picture_url,
               default_action: {
                 type: "web_url",
                 url: "https://m.me/#{event.page_bot.page_id}?ref=invited_by_24601"
               },
               buttons: [
                 {
                   type: "web_url",
                   url: "https://m.me/#{event.page_bot.page_id}?ref=invited_by_24601",
                   title: "Join #{sender.first_name} at #{event.name}"
                 }
               ]
             }
           ]
         }
        }
      }
    }
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
     subtitle: "#{event.addresses.first.to_s}\n#{event.time_windows.first.start_at.strftime('%m/%d/%Y at %l %P')} to #{event.time_windows.first.end_at.strftime('%m/%d/%Y  at %l %P')}",
     buttons: buttons}
  end
end
