class EventRsvpResponder
  include BotInfo
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

  def event_id
    message.payload.split('-').last.to_i
  end
end
